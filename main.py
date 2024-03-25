from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/")
def root():
    return jsonify({"nimbus": "judge"})

@app.route("/judge", methods=["POST"])
def judge():
    body = request.form.to_dict()
    f = request.files['file']
    #f.save(f.filename)
    return jsonify({
        "body": body,
        "file": {
            "name": f.filename.split(".")[0],
            "extention": f.filename.split(".")[1],
            "size": str(len(f.read())),
            "size_type": "bytes"
        }
    })