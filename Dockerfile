FROM public.ecr.aws/lambda/python:3.12

RUN dnf install -y \
    git \
    gcc \
    bc \
    make \
    time \
    tzdata \
    glibc-static \
    diffutils \
    vim \
    gcc-c++

RUN dnf install -y libstdc++-static

ENV TZ=America/Sao_Paulo
RUN ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

COPY src/judge ${LAMBDA_TASK_ROOT}/judge
RUN chmod +x ${LAMBDA_TASK_ROOT}/judge/build-and-test.sh
RUN pip install --upgrade pip

# COPY requirements.txt ./
# RUN pip install -r requirements.txt -t "${LAMBDA_TASK_ROOT}"

COPY src/app.py ${LAMBDA_TASK_ROOT}

CMD [ "app.handler" ]
