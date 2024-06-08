FROM public.ecr.aws/lambda/python:3.12

# SETUP JUDGE
RUN dnf install -y \
    git \
    gcc \
    bc \
    make \
    time \
    tzdata \
    glibc-static \
    diffutils

ENV TZ=America/Sao_Paulo
RUN ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

#COPY judge ${LAMBDA_TASK_ROOT}/tmp/judge
#RUN chmod +x ${LAMBDA_TASK_ROOT}/tmp/judge/build-and-test.sh
COPY src/judge ${LAMBDA_TASK_ROOT}/judge
RUN chmod +x ${LAMBDA_TASK_ROOT}/judge/build-and-test.sh
#RUN pip install --upgrade pip
#RUN pip install awslambdaric -t "${LAMBDA_TASK_ROOT}"
# COPY requirements.txt ./
#RUN pip install -r requirements.txt -t "${LAMBDA_TASK_ROOT}"
COPY src/app.py ${LAMBDA_TASK_ROOT}

CMD [ "app.handler" ]
