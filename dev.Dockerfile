FROM amazonlinux as build-image

# SETUP JUDGE
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

RUN yum -y install libstdc++-static

ENV TZ=America/Sao_Paulo
RUN ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

COPY src/judge ${LAMBDA_TASK_ROOT}/judge

COPY src/app.py ${LAMBDA_TASK_ROOT}

#CMD [ "app.handler" ]
