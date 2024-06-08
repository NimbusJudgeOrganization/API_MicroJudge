import sys
import os
from subprocess import Popen, PIPE
from pathlib import Path
import json
import base64


def cmdline(command):
    process = Popen(args=command, stdout=PIPE, stderr=PIPE, shell=True)
    stdout, stderr = process.communicate()
    return stdout, stderr, process.returncode


def validate_event(event):
    required_fields = ['question', 'encoded_base64_submition', 'file_name']
    for field in required_fields:
        if field not in event:
            raise ValueError(f"Missing required field: {field}")


def handler(event, context):
    try:
        # Validate input
        validate_event(event)
        
        question = event['question']
        encoded_base64_submition = event['encoded_base64_submition']
        file_name = event['file_name']
        
        # Decode base64 content
        try:
            file_content = base64.b64decode(encoded_base64_submition)
        except (TypeError, base64.binascii.Error) as e:
            raise ValueError("Invalid base64 encoding") from e
        
        temp_file_path = f'/tmp/{file_name}'
        with open(temp_file_path, 'wb') as f:
            f.write(file_content)
       
        # If we not have tl, execute calibreitor
        # tl_file_path = f'/tmp/judge/{question}/tl'
        # if not Path(tl_file_path).is_file():
        #     calibreitor = f'bash /tmp/judge/calibreitor.sh /tmp/judge/{question}'
        #     stdout, stderr, returncode = cmdline(calibreitor)

        #     if returncode != 0:
        #         raise RuntimeError(f"Calibreitor failed with return code {returncode}: {stderr.decode('utf-8')}")

        # Execute the command
        command = f'bash judge/build-and-test.sh c /tmp/{file_name} judge/{question}'
        stdout, stderr, returncode = cmdline(command)
        
        if returncode != 0:
            raise RuntimeError(f"Command failed with return code {returncode}: {stderr.decode('utf-8')}")
        
        build_and_test_output = stdout.decode('utf-8')
        lines = build_and_test_output.strip().split('\n')
        status = lines[-1].split(',')[0]
        percentage = int(lines[-1].split(',')[1].replace('p', ''))
        
        response_body = {
            'status': status,
            'percentage': percentage
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
