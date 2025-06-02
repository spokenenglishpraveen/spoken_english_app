from flask import Flask, request, jsonify
from flask_cors import CORS
import os
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
    port = int(os.environ.get("PORT", 5000))  # Render will set PORT env var
    app.run(debug=True, host="0.0.0.0", port=port)
