import sys
import os
from subprocess import Popen, PIPE
from pathlib import Path
import json
import base64
import uuid
import boto3

def cmdline(command):
    process = Popen(args=command, stdout=PIPE, stderr=PIPE, shell=True)
    stdout, stderr = process.communicate()
    return stdout, stderr, process.returncode

def validate_event(event):
    required_fields = ['problemid', 'file64', 'filename', 'language']
    for field in required_fields:
        if field not in event:
            raise ValueError(f"Missing required field: {field}")


def handler(event, context):
    try:
        # Validate input
        validate_event(event)
        
        problemid = event['problemid']
        encoded_base64_submition = event['file64']
        language = event['language']
        filename = event['filename']
        
        # Decode base64 content
        try:
            file_content = base64.b64decode(encoded_base64_submition)
        except (TypeError, base64.binascii.Error) as e:
            raise ValueError("Invalid base64 encoding") from e
        
        temp_file_path = f'/tmp/{filename}'
        with open(temp_file_path, 'wb') as f:
            f.write(file_content)
       
        command = f'bash judge/build-and-test.sh {language} /tmp/{filename} judge/{problemid}'
        stdout, stderr, returncode = cmdline(command)
        
        if returncode != 0:
            raise RuntimeError(f"Command failed with return code {returncode}: {stderr.decode('utf-8')}")
        
        build_and_test_output = stdout.decode('utf-8')
        lines = build_and_test_output.strip().split('\n')
        status = lines[-1].split(',')[0]
        percentage = int(lines[-1].split(',')[1].replace('p', ''))
        
        # save log
        submission_id = str(uuid.uuid4())
        log_file = '/tmp/rwdir/build-and-test.log' 
        s3_bucket_name = 'submissionlog'
        s3_key = f'{submission_id}'
        
        # boto3 s3 client
        s3_client = boto3.client('s3')
        
        # upload to s3
        try:
            s3_client.upload_file(log_file, s3_bucket_name, s3_key)
            print(f"Successfully uploaded {log_file} to s3://{s3_bucket_name}/{s3_key}")
        except Exception as e:
                raise RuntimeError(f"Failed to upload {tl_file_path} to S3: {str(e)}")
        # clean dir 
        cmdline('rm -rf /tmp/*')

        response_body = {
            'status': status,
            'percentage': percentage,
            'logid': submission_id 
        }
        
        return {
            'statusCode': 200,
            'body': json.dumps(response_body)
        }
    except ValueError as ve:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': str(ve)})
        }
    except RuntimeError as re:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(re)})
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': f"Unexpected error: {str(e)}"})
        }
