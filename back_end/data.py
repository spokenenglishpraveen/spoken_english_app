import random

# Flattened sentence bank as a list of dicts with "tense", "telugu", and "english"
sentence_bank = [
    # Simple Present
    {"tense": "Simple Present", "telugu": "నీవు ప్రతిరోజూ ఆఫీసుకు వెళ్తావు.", "english": "You go to office every day."},
    {"tense": "Simple Present", "telugu": "నీవు ప్రతిరోజూ ఆఫీసుకు వెళ్తావా?", "english": "Do you go to office every day?"},
    {"tense": "Simple Present", "telugu": "నీవు ప్రతిరోజూ ఆఫీసుకు ఎందుకు వెళ్తావు?", "english": "Why do you go to office every day?"},
    {"tense": "Simple Present", "telugu": "నీవు ప్రతిరోజూ ఆఫీసుకు ఎప్పుడు వెళ్తావు?", "english": "When do you go to office every day?"},
    {"tense": "Simple Present", "telugu": "నువ్వు ప్రతిరోజూ ఏమి తింటావు ?", "english": "What do you eat every day?"},
    {"tense": "Simple Present", "telugu": "నీవు ప్రతిరోజూ ఎక్కడికి వెళ్ళతావు?", "english": "Where do you go every day?"},
    {"tense": "Simple Present", "telugu": "నీవు ఆఫీసుకు ఎలా వెళ్తావు?", "english": "How do you go to office every day?"},
    {"tense": "Simple Present", "telugu": "నీవు ప్రతిరోజూ ఆఫీసుకు వెళ్ళవు.", "english": "You don't go to office every day."},
    {"tense": "Simple Present", "telugu": "నీవు ప్రతిరోజూ ఆఫీసుకు వెళ్ళవా?", "english": "Don't you go to office every day?"},
    {"tense": "Simple Present", "telugu": "నీవు ప్రతిరోజూ ఆఫీసుకు ఎందుకు వెళ్ళవు?", "english": "Why don't you go to office every day?"},

    {"tense": "Simple Present", "telugu": "ఆమె ప్రతిరోజూ ఆఫీసుకు వెళ్తుంది.", "english": "She goes to office every day."},
    {"tense": "Simple Present", "telugu": "ఆమె ప్రతిరోజూ ఆఫీసుకు వెళ్తుందా?", "english": "Does she go to office every day?"},
    {"tense": "Simple Present", "telugu": "ఆమె ప్రతిరోజూ ఆఫీసుకు ఎందుకు వెళ్తుంది?", "english": "Why does she go to office every day?"},
    {"tense": "Simple Present", "telugu": "ఆమె ప్రతిరోజూ ఆఫీసుకు ఎప్పుడు వెళ్తుంది?", "english": "When does she go to office every day?"},
    {"tense": "Simple Present", "telugu": "ఆమె ప్రతిరోజూ ఏమి తింటుంది?", "english": "What does she eat every day?"},
    {"tense": "Simple Present", "telugu": "ఆమె ప్రతిరోజూ ఎక్కడికి వెళ్తుంది?", "english": "Where does she go every day?"},
    {"tense": "Simple Present", "telugu": "ఆమె ఆఫీసుకు ఎలా వెళ్తుంది?", "english": "How does she go to office every day?"},
    {"tense": "Simple Present", "telugu": "ఆమె ప్రతిరోజూ ఆఫీసుకు వెళ్ళదు.", "english": "She doesn't go to office every day."},
    {"tense": "Simple Present", "telugu": "ఆమె ప్రతిరోజూ ఆఫీసుకు వెళ్ళదా?", "english": "Doesn't she go to office every day?"},
    {"tense": "Simple Present", "telugu": "ఆమె ప్రతిరోజూ ఆఫీసుకు ఎందుకు వెళ్ళదు?", "english": "Why doesn't she go to office every day?"},

    {"tense": "Simple Present", "telugu": "రాము ప్రతిరోజూ ఆఫీసుకు వెళ్తాడు.", "english": "Ramu goes to office every day."},
    {"tense": "Simple Present", "telugu": "రాము ప్రతిరోజూ ఆఫీసుకు వెళ్లాడా?", "english": "Does Ramu go to office every day?"},
    {"tense": "Simple Present", "telugu": "రాము ప్రతిరోజూ ఆఫీసుకు ఎందుకు వెళ్తాడు?", "english": "Why does Ramu go to office every day?"},
    {"tense": "Simple Present", "telugu": "రాము ప్రతిరోజూ ఆఫీసుకు ఎప్పుడు వెళ్తాడు?", "english": "When does Ramu go to office every day?"},
    {"tense": "Simple Present", "telugu": "రాము ప్రతిరోజూ ఏమి తింటాడు?", "english": "What does Ramu eat every day?"},
    {"tense": "Simple Present", "telugu": "రాము ప్రతిరోజూ ఎక్కడికి వెళ్తాడు?", "english": "Where does Ramu go every day?"},
    {"tense": "Simple Present", "telugu": "రాము ఆఫీసుకు ఎలా వెళ్తాడు?", "english": "How does Ramu go to office every day?"},
    {"tense": "Simple Present", "telugu": "రాము ప్రతిరోజూ ఆఫీసుకు వెళ్ళడు.", "english": "Ramu doesn't go to office every day."},
    {"tense": "Simple Present", "telugu": "రాము ప్రతిరోజూ ఆఫీసుకు వెళ్ళడా?", "english": "Doesn't Ramu go to office every day?"},
    {"tense": "Simple Present", "telugu": "రాము ప్రతిరోజూ ఆఫీసుకు ఎందుకు వెళ్ళడు?", "english": "Why doesn't Ramu go to office every day?"},

    {"tense": "Simple Present", "telugu": "వాళ్లు ప్రతిరోజూ ఆఫీసుకు వెళ్తారు.", "english": "They go to office every day."},
    {"tense": "Simple Present", "telugu": "వాళ్లు ప్రతిరోజూ ఆఫీసుకు వెళ్తారా?", "english": "Do they go to office every day?"},
    {"tense": "Simple Present", "telugu": "వాళ్లు ప్రతిరోజూ ఆఫీసుకు ఎందుకు వెళ్తారు?", "english": "Why do they go to office every day?"},
    {"tense": "Simple Present", "telugu": "వాళ్లు ప్రతిరోజూ ఆఫీసుకు ఎప్పుడు వెళ్తారు?", "english": "When do they go to office every day?"},
    {"tense": "Simple Present", "telugu": "వాళ్లు ప్రతిరోజూ ఏమి తింటారు?", "english": "What do they eat every day?"},
    {"tense": "Simple Present", "telugu": "వాళ్లు ప్రతిరోజూ ఎక్కడికి వెళ్తారు?", "english": "Where do they go every day?"},
    {"tense": "Simple Present", "telugu": "వాళ్లు ఆఫీసుకు ఎలా వెళ్తారు?", "english": "How do they go to office every day?"},
    {"tense": "Simple Present", "telugu": "వాళ్లు ప్రతిరోజూ ఆఫీసుకు వెళ్ళరు.", "english": "They don't go to office every day."},
    {"tense": "Simple Present", "telugu": "వాళ్లు ప్రతిరోజూ ఆఫీసుకు వెళ్ళరా?", "english": "Don't they go to office every day?"},
    {"tense": "Simple Present", "telugu": "వాళ్లు ప్రతిరోజూ ఆఫీసుకు ఎందుకు వెళ్ళరు?", "english": "Why don't they go to office every day?"},

    {"tense": "Simple Present", "telugu": "మేము ప్రతిరోజూ ఆఫీసుకు వెళ్తాము.", "english": "We go to office every day."},
    {"tense": "Simple Present", "telugu": "మేము ప్రతిరోజూ ఆఫీసుకు వెళ్తామా?", "english": "Do we go to office every day?"},
    {"tense": "Simple Present", "telugu": "మేము ప్రతిరోజూ ఆఫీసుకు ఎందుకు వెళ్తాము?", "english": "Why do we go to office every day?"},
    {"tense": "Simple Present", "telugu": "మేము ప్రతిరోజూ ఆఫీసుకు ఎప్పుడు వెళ్తాము?", "english": "When do we go to office every day?"},
    {"tense": "Simple Present", "telugu": "మేము ప్రతిరోజూ ఏమి తింటాము?", "english": "What do we eat every day?"},
    {"tense": "Simple Present", "telugu": "మేము ప్రతిరోజూ ఎక్కడికి వెళ్తాము?", "english": "Where do we go every day?"},
    {"tense": "Simple Present", "telugu": "మేము ఆఫీసుకు ఎలా వెళ్తాము?", "english": "How do we go to office every day?"},
    {"tense": "Simple Present", "telugu": "మేము ప్రతిరోజూ ఆఫీసుకు వెళ్ళము.", "english": "We don't go to office every day."},
    {"tense": "Simple Present", "telugu": "మేము ప్రతిరోజూ ఆఫీసుకు వెళ్ళమా?", "english": "Don't we go to office every day?"},
    {"tense": "Simple Present", "telugu": "మేము ప్రతిరోజూ ఆఫీసుకు ఎందుకు వెళ్ళము?", "english": "Why don't we go to office every day?"},

    {"tense": "Simple Present", "telugu": "నేను ప్రతిరోజూ ఆఫీసుకు వెళ్తాను.", "english": "I go to office every day."},
    {"tense": "Simple Present", "telugu": "నేను ప్రతిరోజూ ఆఫీసుకు వెళ్తానా?", "english": "Do I go to office every day?"},
    {"tense": "Simple Present", "telugu": "నేను ప్రతిరోజూ ఆఫీసుకు ఎందుకు వెళ్తాను?", "english": "Why do I go to office every day?"},
    {"tense": "Simple Present", "telugu": "నేను ప్రతిరోజూ ఆఫీసుకు ఎప్పుడు వెళ్తాను?", "english": "When do I go to office every day?"},
    {"tense": "Simple Present", "telugu": "నేను ప్రతిరోజూ ఏమి తింటాను?", "english": "What do I eat every day?"},
    {"tense": "Simple Present", "telugu": "నేను ప్రతిరోజూ ఎక్కడికి వెళ్తాను?", "english": "Where do I go every day?"},
    {"tense": "Simple Present", "telugu": "నేను ఆఫీసుకు ఎలా వెళ్తాను?", "english": "How do I go to office every day?"},
    {"tense": "Simple Present", "telugu": "నేను ప్రతిరోజూ ఆఫీసుకు వెళ్ళను.", "english": "I don't go to office every day."},
    {"tense": "Simple Present", "telugu": "నేను ప్రతిరోజూ ఆఫీసుకు వెళ్ళనా?", "english": "Don't I go to office every day?"},
    {"tense": "Simple Present", "telugu": "నేను ప్రతిరోజూ ఆఫీసుకు ఎందుకు వెళ్ళను?", "english": "Why don't I go to office every day?"},

    # Simple Past
    {"tense": "Simple Past", "telugu": "నీవు నిన్న ఆఫీసుకు వెళ్లావు.", "english": "You went to office yesterday."},
    {"tense": "Simple Past", "telugu": "నీవు నిన్న ఆఫీసుకు వెళ్లావా?", "english": "Did you go to office yesterday?"},
    {"tense": "Simple Past", "telugu": "నీవు నిన్న ఎందుకు వెళ్లావు?", "english": "Why did you go yesterday?"},
    {"tense": "Simple Past", "telugu": "నీవు నిన్న ఎలా వెళ్లావు?", "english": "How did you go yesterday?"},
    {"tense": "Simple Past", "telugu": "నీవు నిన్న ఎక్కడికి వెళ్లావు?", "english": "Where did you go yesterday?"},
    {"tense": "Simple Past", "telugu": "నీవు నిన్న ఎప్పుడు వెళ్లావు?", "english": "When did you go yesterday?"},
    {"tense": "Simple Past", "telugu": "నీవు నిన్న ఆఫీసుకు వెళ్లలేదు.", "english": "You did not go to office yesterday."},
    {"tense": "Simple Past", "telugu": "నీవు నిన్న ఆఫీసుకు వెళ్లలేదా?", "english": "Didn't you go to office yesterday?"},
    {"tense": "Simple Past", "telugu": "నీవు నిన్న ఎందుకు వెళ్లలేదు?", "english": "Why didn't you go yesterday?"},

    {"tense": "Simple Past", "telugu": "ఆమె నిన్న ఆఫీసుకు వెళ్లింది.", "english": "She went to office yesterday."},
    {"tense": "Simple Past", "telugu": "ఆమె నిన్న ఆఫీసుకు వెళ్లిందా?", "english": "Did she go to office yesterday?"},
    {"tense": "Simple Past", "telugu": "ఆమె నిన్న ఎందుకు వెళ్లింది?", "english": "Why did she go yesterday?"},
    {"tense": "Simple Past", "telugu": "ఆమె నిన్న ఎలా వెళ్లింది?", "english": "How did she go yesterday?"},
    {"tense": "Simple Past", "telugu": "ఆమె నిన్న ఎక్కడికి వెళ్లింది?", "english": "Where did she go yesterday?"},
    {"tense": "Simple Past", "telugu": "ఆమె నిన్న ఎప్పుడు వెళ్లింది?", "english": "When did she go yesterday?"},
    {"tense": "Simple Past", "telugu": "ఆమె నిన్న ఆఫీసుకు వెళ్లలేదు.", "english": "She did not go to office yesterday."},
    {"tense": "Simple Past", "telugu": "ఆమె నిన్న ఆఫీసుకు వెళ్లలేదా?", "english": "Didn't she go to office yesterday?"},
    {"tense": "Simple Past", "telugu": "ఆమె నిన్న ఎందుకు వెళ్లలేదు?", "english": "Why didn't she go yesterday?"},

    # Simple Future
    {"tense": "Simple Future", "telugu": "నేను రేపు ఆఫీసుకు వెళ్ళనున్నాను.", "english": "I will go to office tomorrow."},
    {"tense": "Simple Future", "telugu": "నేను రేపు ఆఫీసుకు వెళ్ళనా?", "english": "Will I go to office tomorrow?"},
    {"tense": "Simple Future", "telugu": "నేను రేపు ఎందుకు వెళ్ళనున్నాను?", "english": "Why will I go tomorrow?"},
    {"tense": "Simple Future", "telugu": "నేను రేపు ఎలా వెళ్ళనున్నాను?", "english": "How will I go tomorrow?"},
    {"tense": "Simple Future", "telugu": "నేను రేపు ఎక్కడికి వెళ్ళనున్నాను?", "english": "Where will I go tomorrow?"},
    {"tense": "Simple Future", "telugu": "నేను రేపు ఎప్పుడు వెళ్ళనున్నాను?", "english": "When will I go tomorrow?"},
    {"tense": "Simple Future", "telugu": "నేను రేపు ఆఫీసుకు వెళ్లను.", "english": "I will not go to office tomorrow."},
    {"tense": "Simple Future", "telugu": "నేను రేపు ఆఫీసుకు వెళ్లనా?", "english": "Won't I go to office tomorrow?"},
    {"tense": "Simple Future", "telugu": "నేను రేపు ఎందుకు వెళ్లను?", "english": "Why won't I go tomorrow?"}
]

def get_random_sentence():
    """Return a random sentence dictionary from the entire bank."""
    return random.choice(sentence_bank)

def get_random_sentence_by_tense(tense):
    """Return a random sentence dictionary filtered by tense."""
    filtered = [s for s in sentence_bank if s["tense"] == tense]
    return random.choice(filtered) if filtered else None
