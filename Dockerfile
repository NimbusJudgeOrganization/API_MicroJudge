FROM public.ecr.aws/lambda/python:3.10

COPY app.py ./
COPY chalicelib ./
COPY requiriments.txt ./
RUN pip install -r requiriments.txt
CMD ["app.app"]
