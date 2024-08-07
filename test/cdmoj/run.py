import boto3
import base64
import json
import os
import threading
import time
import random
import uuid
import re
from prettytable import PrettyTable

resp = { 'AC': 'Accepted', 'TL': 'Time Limit Exceeded'}
resp_invesed = { 'Accepted': 'AC', 'Time Limit Exceeded': 'TL'}

with open('fso-escalonador-round-robin.json') as fp:
    probs1 = json.load(fp)

with open('primos_arrojados.json') as fp:
    probs2 = json.load(fp)

logs = []

def process_log(log64, status, expected_status, logid, exec_time):
    log_content = base64.b64decode(log64).decode('utf-8')

    pattern = r'Execution Time: ([\d.]+)'
    matches = re.findall(pattern, log_content, re.MULTILINE)
    total_time = 0.0
    test_count = 0

    for match in matches:
        test_count += 1
        test_case_time = float(match)
        total_time += test_case_time

    pattern_build_and_test_time = r'Total build-and-test time: ([\d.]+) seconds'
    match = re.search(pattern_build_and_test_time, log_content)
    if match:
        build_and_test_time = match.group(1)

    average_time = total_time / test_count if test_count > 0 else 0
    create_log(logid, 'nimbus', build_and_test_time, test_count, total_time, average_time, status, resp[expected_status])
    logs.append([resp_invesed[status], expected_status, build_and_test_time, f'{total_time:.3f}', f'{average_time:.3f}', logid])


def create_log(logid, judge, build_and_test_time, test_case_lenght, test_case_sum_time, test_case_avg_time, status, expected):
    if judge != 'cdmoj' and judge != 'nimbus':
        raise Exception('Unexpected judge name, please use <cdmoj> or <nimbus>')

    dynamo = boto3.resource('dynamodb')
    # table = dynamo.Table('nimbus_fso-escalonador-round-robin')
    table = dynamo.Table('nimbus_not_parallel_fso-escalonador-round-robin')

    item = {
            'logid': logid,
            'judge': judge,
            'build_and_test_time': str(build_and_test_time),
            'test_case_lenght': str(test_case_lenght),
            'test_case_sum_time': str(test_case_sum_time),
            'test_case_avg_time': str(test_case_avg_time),
            'status': status,
            'expected': expected
            }

    table.put_item(Item=item)


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


def invoke_lambda(code_dir, problemid, language, expected_status):
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
    functions = [f for f in functions if 'lambda-test' in f['FunctionName']] 
    sorted_functions = sorted(functions, key=lambda x: x["LastModified"], reverse=True)
    target_function_name = sorted_functions[0]["FunctionName"]

    response = lambda_client.invoke(
            FunctionName=target_function_name,
            InvocationType="RequestResponse",
            Payload=payload
            )

    body = json.loads(response["Payload"].read().decode())['body']
    logid = json.loads(body)['logid']
    status = json.loads(body)['status']
    log64 = json.loads(body)['log64']
    exec_time = int(json.loads(body)['execution_time'])

    process_log(log64, status, expected_status, logid, exec_time)
    return logid


def invoke_random_problem():
    category = random.choice(list(probs1.keys()))
    problem = random.choice(probs1[category])
    invoke_lambda(problem['file'], problem['problem'], problem['language'], str(category))


if __name__ == '__main__':
    jobs_count = int(input('Insert job quantity: ' ))
    # jobs_count = 5
    print(f'Estimate time for invoking lambdas: {jobs_count*1.15}s')
    print('Starting Jobs...')
    threads = []
    for _ in range(jobs_count):
        t = threading.Thread(target=invoke_random_problem)
        threads.append(t)
        t.start()
        time.sleep(1)

    for t in threads:
        t.join()

    table = PrettyTable()
    table.field_names = ["Status", "Expected", "build-and-test Time", "TC: Total Time", "TC: Avg Exec Time", "logid"]

    for log in logs:
        table.add_row(log)

    print(table)

