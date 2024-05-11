import sys
import os
def handler(event, context):
    print('Hello from AWS Lambda using Python' + sys.version + '!')
    print('-> ls')
    os.system('ls')
    print('-> ls judge')
    os.system('ls judge')
    print('-> calibreitor')
    os.system('/judge/./calibreitor.sh /judge/fatorial')
    print('-> gcc')
    os.system('gcc /judge/jorge.c')
    return 'ok'
