#!/bin/bash

REPOSITORY_NAME="calibreitor_tl"
AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="992382630933"
IMAGE_NAME="calibreitor-test-$(date '+%d-%m-%Y-%H-%M-%S')"
LOGFILE="image_push.log"

LOG() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOGFILE
}

REPOSITORY_URL="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

LOG "Login in ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $REPOSITORY_URL

LOG "Building new image..."
docker build -t calibreitor_tl -f calibreitor.Dockerfile .

FULL_IMAGE_URI="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPOSITORY_NAME:latest"

LOG "Generatin image tag..."
docker tag $REPOSITORY_NAME:latest $FULL_IMAGE_URI

LOG "Sending image to ECR repository..."
docker push $FULL_IMAGE_URI

IMAGE_DIGEST=$(aws ecr describe-images --repository-name lambda_test --image-ids imageTag=latest --query 'imageDetails[0].imageDigest' --output text)

LOG "Sucessfuly sending new image!"
LOG "New image hash: $IMAGE_DIGEST"
