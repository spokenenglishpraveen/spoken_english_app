from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
import os
from data import get_random_sentence, get_random_by_tense

app = Flask(__name__, static_folder='frontend/build/web', static_url_path='/')
CORS(app)

@app.route("/get_random_sentence")
def random_sentence():
    return jsonify(get_random_sentence())

@app.route("/get_sentence_by_tense")
def sentence_by_tense():
    tense = request.args.get("tense")
    return jsonify(get_random_by_tense(tense))

# Serve Flutter static files and index.html for all other routes
@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def serve_frontend(path):
    if path != "" and os.path.exists(os.path.join(app.static_folder, path)):
        return send_from_directory(app.static_folder, path)
    else:
        # fallback to index.html for SPA routing
        return send_from_directory(app.static_folder, 'index.html')

if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))  # Render will set PORT env var
    app.run(debug=True, host="0.0.0.0", port=port)
