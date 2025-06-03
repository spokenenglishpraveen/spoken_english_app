# data.py

tense_sentences = {
    "Simple Present": [
        {"telugu": "అవుడు పుస్తకాలు చదువుతాడు", "english": "He reads books"}
    ],
    "Have to": [
        {"telugu": "నాకు పరీక్ష రాయాలి", "english": "I have to write an exam"}
    ],
    "Past Tense": [
        {"telugu": "నేను వెళ్ళాను", "english": "I went"}
    ],
}

import random

def get_random_sentence():
    all_sentences = []
    for group in tense_sentences.values():
        all_sentences.extend(group)
    return random.choice(all_sentences)

def get_random_by_tense(tense):
    return random.choice(tense_sentences.get(tense, []))
