FROM ubuntu

RUN apt update -y && apt upgrade -y

RUN apt install python3 git -y
RUN apt install python3-venv python3-pip -y

RUN git clone https://github.com/NimbusJudgeOrganization/ec2-api.git --recursive

WORKDIR /ec2-api

# RUN source venv/bin/activate
RUN pip install -r requirements.txt
