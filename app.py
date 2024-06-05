import sys
import os
from subprocess import Popen, PIPE
import json
import base64

def cmdline(command):
    process = Popen(
        args=command,
        stdout=PIPE,
        shell=True
    )
    return process.communicate()[0]

def handler(event, context):
    try:
        question = event['question']
        encoded_base64_submition = event['encoded_base64_submition']
        file_name = event['file_name']
        
        # Decodifique o conteúdo base64
        file_content = base64.b64decode(encoded_base64_submition)
        print(file_content)
        
        temp_file_path = f'/tmp/{file_name}'
        with open(temp_file_path, 'wb') as f:
            f.write(file_content)
        
        build_and_test_output = cmdline(f'bash judge/build-and-test.sh c /tmp/{file_name} judge/{question}').decode('utf-8')
        
        lines = build_and_test_output.strip().split('\n')
        status = lines[-1].split(',')[0]
        percentage = int(lines[-1].split(',')[1].replace('p', ''))
        
        response = {
            'statusCode': 200,
            'body': json.dumps({
                'status': status,
                'percentage': percentage
            })
        }
        
        return response
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Error: {str(e)}")
        }
