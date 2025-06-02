from flask import Flask, jsonify, request
import os

app = Flask(__name__)

# Example sentence data (You can expand this or load from DB/file)
sentences = [
    {"id": 1, "english": "How are you?", "telugu": "మీరు ఎలా ఉన్నారు?"},
    {"id": 2, "english": "What is your name?", "telugu": "మీ పేరు ఏమిటి?"},
    {"id": 3, "english": "I like apples.", "telugu": "నాకు సేపులు ఇష్టం."}
]

@app.route('/')
def home():
    return jsonify({"message": "Welcome to Spoken English API!"})

# Get sentence by id
@app.route('/sentence/<int:sentence_id>', methods=['GET'])
def get_sentence(sentence_id):
    for s in sentences:
        if s['id'] == sentence_id:
            return jsonify({"id": s['id'], "english": s['english']})
    return jsonify({"error": "Sentence not found"}), 404

# Check answer
@app.route('/check_answer', methods=['POST'])
def check_answer():
    data = request.json
    sentence_id = data.get("id")
    user_translation = data.get("translation", "").strip()

    # Find the correct telugu answer
    sentence = next((s for s in sentences if s['id'] == sentence_id), None)
    if not sentence:
        return jsonify({"error": "Sentence not found"}), 404

    correct_answer = sentence['telugu'].strip()

    is_correct = (user_translation == correct_answer)
    return jsonify({"correct": is_correct, "correct_answer": correct_answer})

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)
