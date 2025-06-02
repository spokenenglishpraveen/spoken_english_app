from flask import Flask, jsonify, request
import os

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({"message": "Welcome to Spoken English API!"})

# Example API endpoint
@app.route('/practice', methods=['POST'])
def practice():
    data = request.json
    # Example: just echo the received data
    return jsonify({"received_data": data})

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))  # Use Render's assigned port or default to 5000
    app.run(host='0.0.0.0', port=port)
