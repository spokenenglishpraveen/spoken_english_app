from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
import os
from data import get_random_sentence, get_random_by_tense, tense_sentences  # your data import

app = Flask(__name__, static_folder='frontend/build/web', static_url_path='/')

# Allow CORS for all origins on all routes - helps Flutter web requests succeed
CORS(app, resources={r"/*": {"origins": "*"}})

@app.before_request
def log_request_info():
    print(f"Received {request.method} request for {request.path} from {request.remote_addr}")

@app.route("/get_random_sentence")
def random_sentence():
    data = get_random_sentence()
    print("Serving random sentence:", data)
    return jsonify(data)

@app.route("/get_sentence_by_tense")
def sentence_by_tense():
    tense = request.args.get("tense")
    print(f"Received tense query: {tense}")
    data = get_random_by_tense(tense)
    print("Serving tense-based sentence:", data)
    return jsonify(data)

@app.route("/get_all_tenses")
def get_all_tenses():
    tenses = list(tense_sentences.keys())
    print("Serving all tenses list:", tenses)
    return jsonify(tenses)

# Serve Flutter static files and index.html for SPA routing fallback
@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def serve_frontend(path):
    static_path = os.path.join(app.static_folder, path)
    if path != "" and os.path.exists(static_path):
        print(f"Serving static file: {path}")
        return send_from_directory(app.static_folder, path)
    else:
        print("Serving index.html fallback")
        return send_from_directory(app.static_folder, 'index.html')

if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))
    print(f"Starting Flask app on 0.0.0.0:{port}")
    app.run(debug=True, host="0.0.0.0", port=port)
