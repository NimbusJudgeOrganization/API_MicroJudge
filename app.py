import sys
import os
def handler(event, context):
    print('Hello from AWS Lambda using Python' + sys.version + '!')
    print('-> ls')
    os.system('ls')
    print('-> ls judge')
    os.system('ls judge')
    # print('-> calibreitor')
    # os.system('/judge/./calibreitor.sh /judge/fatorial')
    print('-> build-and-test')
    os.system('/judge/./build-and-test.sh c /judge/jorge.c /judge/fatorial')
    print('-> ls /tmp/rwdir')
    os.system('ls /tmp/rwdir')
    print('-> cat /tmp/rwdir/test-016-team_output')
    os.system('cat /tmp/rwdir/test-016-team_output')
    print('-> cat /tmp/rwdir/build-and-test.log')
    os.system('cat /tmp/rwdir/build-and-test.log')
    return 'ok'
