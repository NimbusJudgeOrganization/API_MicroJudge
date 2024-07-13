"""
This module contains functions to handle and process question submissions for the Nimbus Judge.
"""

import base64
import json
import re
import uuid
from subprocess import PIPE, Popen
import botocore.exceptions
import boto3


def cmdline(command):
    """
    Executes a command in the shell and captures its stdout, stderr, and return code.

    Args:
        command (str): The command to execute.

    Returns:
        tuple: A tuple containing stdout, stderr, and the return code.
    """
    with Popen(args=command, stdout=PIPE, stderr=PIPE, shell=True) as process:
        stdout, stderr = process.communicate()
        return stdout, stderr, process.returncode


def validate_event(event):
    """
    Validates the incoming event to ensure all required fields are present.

    Args:
        event (dict): The event to validate.

    Raises:
        ValueError: If a required field is missing from the event.
    """
    required_fields = ["problemid", "file64", "filename", "language"]
    for field in required_fields:
        if field not in event:
            raise ValueError(f"Missing required field: {field}")


def handler(event, context):
    """
    AWS Lambda handler function to process an question submission and run the Nimbus Judge scripts.

    Args:
        event (dict): The event data passed to the Lambda function.

    Returns:
        dict: The response containing the status code and body with the results.
    """
    try:
        validate_event(event)

        problemid = event["problemid"]
        encoded_base64_submition = event["file64"]
        language = event["language"]
        filename = event["filename"]

        # Decode base64 content
        try:
            file_content = base64.b64decode(encoded_base64_submition)
        except (TypeError, base64.binascii.Error) as e:
            raise ValueError("Invalid base64 encoding") from e

        temp_file_path = f"/tmp/{filename}"
        with open(temp_file_path, "wb") as f:
            f.write(file_content)
        # Build the command line for judge
        build_and_test_response = "/tmp/build_and_test_response"
        command = f"/usr/bin/time -p bash judge/build-and-test.sh {language} \
                /tmp/{filename} judge/{problemid}\
                > {build_and_test_response}"
        _, stderr, returncode = cmdline(command)

        if returncode != 0:
            raise RuntimeError(
                f"Command failed with return code {returncode}: {stderr.decode('utf-8')}"
            )

        with open(build_and_test_response, "r", encoding="utf-8") as f:
            build_and_test_output = f.read()

        execution_time_output = stderr.decode("utf-8")
        time_pattern = re.compile(r"^user (\d+\.\d+)$", re.MULTILINE)
        match = time_pattern.search(execution_time_output)
        execution_time = float(match.group(1))

        lines = build_and_test_output.strip().split("\n")
        status = lines[-1].split(",")[0]
        percentage = int(lines[-1].split(",")[1].replace("p", ""))

        # Upload log to s3
        submission_id = str(uuid.uuid4())
        log_file = "/tmp/rwdir/build-and-test.log"
        s3_bucket_name = "submissionlog"
        s3_key = f"{submission_id}"

        s3_client = boto3.client("s3")

        try:
            s3_client.upload_file(log_file, s3_bucket_name, s3_key)
            print(f"Successfully uploaded {log_file} to s3://{s3_bucket_name}/{s3_key}")
        except botocore.exceptions.BotoCoreError as e:
            raise RuntimeError(f"Failed to upload {log_file} to S3: {str(e)}") from e

        with open(log_file, "r", encoding="utf-8") as f:
            log_content = f.read()

        log64 = base64.b64encode(log_content.encode("utf-8")).decode("utf-8")

        cmdline("rm -rf /tmp/*")
        response_body = {
            "status": status,
            "percentage": percentage,
            "logid": submission_id,
            "log64": log64,
            "execution_time": execution_time,
        }

        return {"statusCode": 200, "body": json.dumps(response_body)}
    except ValueError as ve:
        return {"statusCode": 400, "body": json.dumps({"error": str(ve)})}
    except (RuntimeError, botocore.exceptions.BotoCoreError) as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": f"Unexpected error: {str(e)}"}),
        }
