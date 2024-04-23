from chalice import Chalice
import subprocess

app = Chalice(app_name='api')


@app.route('/')
def index():
    return {'hello': 'world'}


@app.route('/judge', methods=['GET','POST'])
def judge():
    request = app.current_request
    if request.method == 'POST':
        try:
            print("start judging...")
            # run judge for test
            #return_value = shell("/JUDGE_MicroJudge/Judge/./calibreitor fatorial")
            calibreitor = subprocess.run(
                    ["JUDGE_MicroJudge/Judge/./calibreitor.sh", "fatorial"],
                    capture_output = True,
                    text = True
            ).stdout
            print(calibreitor)
            return {'response': f'{calibreitor}'}
        except:
            return "something went wrong"
    elif request.method == 'GET':
        return {'message': 'route in development'}
    else:
        return {'message': 'method not allowed'}
