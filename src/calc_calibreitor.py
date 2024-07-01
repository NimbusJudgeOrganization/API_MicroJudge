import sys
import os
from subprocess import Popen, PIPE
from pathlib import Path
import json
import boto3


def cmdline(command):
    process = Popen(args=command, stdout=PIPE, stderr=PIPE, shell=True)
    stdout, stderr = process.communicate()
    return stdout, stderr, process.returncode


def validate_event(event):
    required_fields = ['question']
    for field in required_fields:
        if field not in event:
            raise ValueError(f"Missing required field: {field}")


def handler(event, context):
    try:
        # Validate input
        validate_event(event)
        
        question = event['question']
       
        tl_file_path = f'/tmp/judge/{question}/tl'
        calibreitor = f'bash judge/calibreitor_lambda.sh {question}'
        stdout, stderr, returncode = cmdline(calibreitor)

        if returncode != 0:
            raise RuntimeError(f"Calibreitor failed with return code {returncode}: {stderr.decode('utf-8'), stdout.decode('utf-8')}")
        
        # add calibreitor response to S3
        s3_bucket_name = 'calibreitortl'
        s3_key = f'{question}/tl'
        
        # boto3 s3 client
        s3_client = boto3.client('s3')
        
        # upload to s3
        try:
            s3_client.upload_file(tl_file_path, s3_bucket_name, s3_key)
            print(f"Successfully uploaded {tl_file_path} to s3://{s3_bucket_name}/{s3_key}")
        except Exception as e:
                raise RuntimeError(f"Failed to upload {tl_file_path} to S3: {str(e)}")
        
        response_body = {
            'stdout': stdout.decode('utf-8'),
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
