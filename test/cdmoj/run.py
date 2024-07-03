# 1000 submissions of the question fso-escalonador-round-robin in nimbus and cd-moj
import boto3
import base64
import json
import os

def create_log(time, status, judge):
    if judge != 'cdmoj' or judge != 'nimbus':
        raise Exception('Unexpected judge name, please use <cdmoj> or <nimbus>')
    
    dynamo = boto3.resource('dynamo')
    table = dynamo.Table('cdmoj_vs_nimbus_fso-escalonador-round-robin')

    Item={
        'judge_time': time,
        'status': status,
        'judge': judge
    }

    table.put_item(Item)
    return Item

def encode_to_base64(file_path):
    try:
        with open(file_path, "rb") as file:
            file_content = file.read()

            encoded_content = base64.b64encode(file_content)

            return encoded_content.decode("utf-8")
    except FileNotFoundError:
        print(f"File not found: {file_path}")
        return None
    except Exception as e:
        print(f"Error encoding file: {e}")
        return None


def invoke_nimbus(code_dir, question):
    code_path = os.path.join(os.getcwd(), code_dir)
    encoded_content = encode_to_base64(code_path)
    payload = {
        "question": question,
        "encoded_base64_submition": encoded_content,
        "file_name": str(question + '.c')
    }
    payload = json.dumps(payload)

    lambda_client = boto3.client("lambda", region_name="us-east-1")

    target_function_name = "cdmoj_vs_nimbus_fso-escalonador-round-robin"

    response = lambda_client.invoke(
        FunctionName=target_function_name,
        InvocationType="RequestResponse",
        Payload=payload
    )

    # submission status
    body = json.loads(response["Payload"].read().decode())['body']
    status = json.loads(body)['status']

    # submission execution time
    log_result = base64.b64decode(response['LogResult']).decode('utf-8')
    execution_time = None
    for line in log_result.split('\n'):
        if 'Duration:' in line:
            execution_time = line.split('Duration:')[1].split(' ')[1]
            break
        
    return status, execution_time, 'nimbus'

if __name__ == '__main__':
    print('Developing...')
