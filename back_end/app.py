# app.py
from flask import Flask, jsonify, request
from data import get_sentences_by_tense

app = Flask(__name__)

@app.route('/sentences')
def sentences():
    tense = request.args.get('tense')
    data = get_sentences_by_tense(tense) if tense else []
    return jsonify(data)

if __name__ == '__main__':
    app.run()
