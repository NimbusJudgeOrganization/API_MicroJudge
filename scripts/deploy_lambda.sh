#!/bin/bash

# Variáveis
REPOSITORY_NAME="lambda_test"
AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="992382630933"
ROLE_ARN="arn:aws:iam::$AWS_ACCOUNT_ID:role/lambda-test"
FUNCTION_NAME="lambda-test-$(date '+%d-%m-%Y-%H-%M-%S')"
LOGFILE="lambda_creation.log"
MEMORY_SIZE=1024
TIMEOUT=40

> $LOGFILE

# Função de logging
LOG() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOGFILE
}

# Obter a tag da última imagem publicada no repositório ECR
LOG "Obtendo a tag da última imagem publicada no repositório ECR..."
LATEST_TAG=$(aws ecr describe-images --repository-name $REPOSITORY_NAME --region $AWS_REGION --query 'sort_by(imageDetails,&imagePushedAt)[-1].imageTags[0]' --output text)

if [ -z "$LATEST_TAG" ]; then
    LOG "Nenhuma imagem encontrada no repositório ECR $REPOSITORY_NAME"
    exit 1
fi

LOG "Última tag encontrada: $LATEST_TAG"

# Construir o URI completo da imagem
FULL_IMAGE_URI="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPOSITORY_NAME:$LATEST_TAG"

# Verificar se a imagem existe no ECR
LOG "Verificando a existência da imagem $FULL_IMAGE_URI no ECR..."
IMAGE_EXISTS=$(aws ecr describe-images --repository-name $REPOSITORY_NAME --image-ids imageTag=$LATEST_TAG --region $AWS_REGION --query 'imageDetails[0].imageDigest' --output text)

if [ -z "$IMAGE_EXISTS" ]; then
    LOG "A imagem $FULL_IMAGE_URI não existe ou não é válida."
    exit 1
fi

LOG "A imagem $FULL_IMAGE_URI foi encontrada e é válida."

# Criar a função Lambda
LOG "Criando a função Lambda com a imagem $FULL_IMAGE_URI..."
aws lambda create-function \
  --function-name $FUNCTION_NAME \
  --package-type Image \
  --code ImageUri=$FULL_IMAGE_URI \
  --role $ROLE_ARN \
  --timeout $TIMEOUT \
  --memory-size $MEMORY_SIZE 2>> $LOGFILE 


if [[ $? -ne 0 ]]; then
    LOG "Erro ao criar a função Lambda. Verifique os detalhes no log."
    exit 1
fi

LOG "Função Lambda criada com sucesso: $FUNCTION_NAME"
LOG "Imagem utilizada: $FULL_IMAGE_URI"

