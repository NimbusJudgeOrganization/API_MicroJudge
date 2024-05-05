from chalice import Chalice, Response
from subprocess import Popen, PIPE
import os
import cgi
from io import BytesIO
import uuid

app = Chalice(app_name='api')

cwd = os.getcwd()
JUDGE_DIR = f"{cwd}/chalicelib/JUDGE_MicroJudge/Judge"


def cmdline(command):
    process = Popen(
        args=command,
        stdout=PIPE,
        shell=True
    )
    return process.communicate()[0]


def _get_parts():
    rfile = BytesIO(app.current_request.raw_body)
    content_type = app.current_request.headers['content-type']
    _, parameters = cgi.parse_header(content_type)
    parameters['boundary'] = parameters['boundary'].encode('utf-8')
    parsed = cgi.parse_multipart(rfile, parameters)
    return parsed


@app.route('/')
def index():
    return {'hello': 'nimbus'}


@app.route('/judge', methods=['GET','POST'], content_types=["multipart/form-data"])
def judge():
    request = app.current_request
    body = _get_parts()
    try:
        _file = body['file'][0]
        _question = body['question'][0]
    except:
        return Response(body="Bad request, file or question_name not found in body data.",
                        status_code=400,
                        headers={'Content-Type': 'text/plain'})
    if request.method == 'POST':
        try:
            print('---- SUBMISSION RECIVED ----')
            print('📁 SETUP FILES STAGE')
            filename = str(uuid.uuid4()) + '.c'
            with open(f'{JUDGE_DIR}/{filename}', 'wb') as uploaded_file:
                uploaded_file.write(_file)
            print(f'NEW FILE CREATED {filename}')


            print('⚖️ JUDGE STAGE')
            if os.path.isfile(f'{JUDGE_DIR}/{_question}/tl'):
                print('TL ALREADY EXISTS')
            else:
                _calibreitor_in = f"{JUDGE_DIR}/./calibreitor.sh {JUDGE_DIR}/{_question}"
                _calibreitor_out = cmdline(_calibreitor_in)
                print(f'CALIBREITOR OUTPUT: {_calibreitor_out}')
                print(f'TL FILE CREATED')
                print('✅CALIBREITOR FINISH')

            _build_and_test_in = f"{JUDGE_DIR}/./build-and-test.sh c {JUDGE_DIR}/{filename} {JUDGE_DIR}/{_question}"
            _build_and_test_out = str(cmdline(_build_and_test_in))
            print(f'BUILD_AND_TEST OUTPUT: {_build_and_test_out}')
            print('✅BUILD-AND-TEST FINISH')
            print('🧹CLEANING DIRECTORY')
            os.remove(f'{JUDGE_DIR}/{filename}')
            os.remove(f'{JUDGE_DIR}/{_question}/tl')
            print('---- JUDGE FINISHED ----')
            return Response(body=f'ok',
                            status_code=200,
                            headers={'Content-Type': 'text/plain'})
        except:
            return "something went wrong"
    elif request.method == 'GET':
        return {'message': 'route in development'}
    else:
        return {'message': 'method not allowed'}
