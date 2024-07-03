import base64
import boto3
import json
import pytest
import os


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


def invoke_lambda(code_dir, problemid, language):
    code_path = os.path.join(os.getcwd(), code_dir)
    encoded_content = encode_to_base64(code_path)
    payload = {
        'problemid' : problemid,
        'file64': encoded_content,
        'filename': str(str(problemid + '.')+ language),
        'language': language
    }
    payload = json.dumps(payload)

    lambda_client = boto3.client("lambda", region_name="us-east-1")

    functions = lambda_client.list_functions()["Functions"]
    sorted_functions = sorted(functions, key=lambda x: x["LastModified"], reverse=True)
    target_function_name = sorted_functions[0]["FunctionName"]

    response = lambda_client.invoke(
        FunctionName=target_function_name,
        InvocationType="RequestResponse",
        Payload=payload
    )
    body = json.loads(response["Payload"].read().decode())['body']
    status = json.loads(body)['status']
    return status
