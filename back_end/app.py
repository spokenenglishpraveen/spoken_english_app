from flask import Flask, request, jsonify
from flask_cors import CORS
from data import get_random_sentence, get_random_by_tense

app = Flask(__name__)
CORS(app)

@app.route("/get_random_sentence")
def random_sentence():
    return jsonify(get_random_sentence())

@app.route("/get_sentence_by_tense")
def sentence_by_tense():
    tense = request.args.get("tense")
    return jsonify(get_random_by_tense(tense))

if __name__ == '__main__':
    app.run(debug=True)
