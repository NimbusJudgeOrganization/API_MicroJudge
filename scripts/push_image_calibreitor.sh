#!/bin/bash

REPOSITORY_NAME="lambda_test"
AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="992382630933"
IMAGE_NAME="calibreitor-test-$(date '+%d-%m-%Y-%H-%M-%S')"
LOGFILE="image_push.log"

LOG() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOGFILE
}

REPOSITORY_URL="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

LOG "Logando no ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $REPOSITORY_URL

LOG "Buildando nova imagem..."
docker build -t lambda_test -f calibreitor.Dockerfile .

FULL_IMAGE_URI="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPOSITORY_NAME:latest"

LOG "Criando a tag para a nova imagem..."
docker tag $REPOSITORY_NAME:latest $FULL_IMAGE_URI

LOG "Enviando nova imagem para o repositório do ECR..."
docker push $FULL_IMAGE_URI

IMAGE_DIGEST=$(aws ecr describe-images --repository-name lambda_test --image-ids imageTag=latest --query 'imageDetails[0].imageDigest' --output text)

LOG "Imagem enviada com sucesso!"
LOG "Hash da nova imagem: $IMAGE_DIGEST"
