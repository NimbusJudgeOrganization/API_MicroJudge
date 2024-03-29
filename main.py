from flask import Flask, request, jsonify
import os
import uuid
import re

app = Flask(__name__)

UPLOAD_FOLDER = 'submissions'
JUDGE_FOLDER = 'judge/Judge'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
ALLOWED_EXTENSIONS = {'cpp', 'c', 'java', 'py'}

@app.route("/")
def root():
    return jsonify({"nimbus": "judge"})

@app.route("/judge", methods=["POST"])
def judge():
    try:
        if 'file' not in request.files:
            return jsonify({"error": "No file part"}), 400

        file = request.files['file']
        if file.filename == '':
            return jsonify({"error": "No selected file"}), 400
        
        # question name
        question = request.form.get("question")
        if not question:
            return jsonify({"error": "No question selected"}), 400

        # check file extension
        if file.filename.split('.')[-1] not in ALLOWED_EXTENSIONS:
            return jsonify({"error": "File extension not allowed"}), 400
        
        # setup file name
        fileExtention = file.filename.split('.')[-1]
        filename = str(uuid.uuid4()) + "." + fileExtention
        
        # save file
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        
        # setup judge
        os.system(f"cp {UPLOAD_FOLDER}/{filename} {JUDGE_FOLDER}/{filename}")
        
        # run judge
        os.system(f'./{JUDGE_FOLDER}/build-and-test.sh {fileExtention} {filename} {question} > result.txt')
        
        # clear directory
        os.system(f"rm {JUDGE_FOLDER}/{filename}")
        
        # return result
        result = open("result.txt", "r").read()
        os.system(f"rm result.txt")
        
        return jsonify({
            "result": re.findall(r'\n(.*?)\n', result)
            }), 200
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500
