FROM ubuntu as build-image


# SETUP JUDGE
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y && apt install -y \
    git \
    gcc \
    bc \
    make \
    time \
    tzdata \
    python3 \
    python3-pip


ENV TZ=America/Sao_Paulo
RUN ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

COPY judge ${LAMBDA_TASK_ROOT}/judge

RUN pip install --upgrade pip
RUN pip install awslambdaric -t "${LAMBDA_TASK_ROOT}"
# COPY requirements.txt ./
#RUN pip install -r requirements.txt -t "${LAMBDA_TASK_ROOT}"
COPY app.py ${LAMBDA_TASK_ROOT}

ENTRYPOINT [ "python3", "-m", "awslambdaric" ]

CMD [ "app.handler" ]
