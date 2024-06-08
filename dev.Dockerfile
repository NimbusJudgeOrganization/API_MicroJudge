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
    vim

ENV TZ=America/Sao_Paulo
RUN ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

COPY judge /tmp/judge

COPY app.py ${LAMBDA_TASK_ROOT}

#CMD [ "app.handler" ]
