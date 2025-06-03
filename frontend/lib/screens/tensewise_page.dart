import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TenseWisePage extends StatefulWidget {
  @override
  _TenseWisePageState createState() => _TenseWisePageState();
}

class _TenseWisePageState extends State<TenseWisePage> {
  final List<String> tenses = [
    "Simple Present",
    "Have to",
  ];

  String selectedTense = "Simple Present";
  String teluguSentence = "";
  String correctEnglish = "";
  String userAnswer = "";
  String result = "";

  @override
  void initState() {
    super.initState();
    fetchSentence();
  }

  Future<void> fetchSentence() async {
    final response = await http.get(Uri.parse(
        'http://localhost:5000/get_sentence_by_tense?tense=${Uri.encodeComponent(selectedTense)}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        teluguSentence = data['telugu'] ?? '';
        correctEnglish = data['english'] ?? '';
        userAnswer = "";
        result = "";
      });
    } else {
      setState(() {
        teluguSentence = "Failed to load sentence.";
        correctEnglish = "";
        result = "";
      });
    }
  }

  void checkAnswer() {
    setState(() {
      result = userAnswer.trim().toLowerCase() == correctEnglish.toLowerCase()
          ? "✅ Correct!"
          : "❌ Incorrect. Answer: $correctEnglish";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tense-wise Practice")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedTense,
              onChanged: (value) {
                setState(() {
                  selectedTense = value!;
                  fetchSentence();
                });
              },
              items: tenses.map((tense) {
                return DropdownMenuItem(
                  value: tense,
                  child: Text(tense),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text("Translate this sentence:", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(teluguSentence, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: "Your English Translation"),
              onChanged: (value) {
                userAnswer = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: checkAnswer, child: Text("Check Answer")),
            SizedBox(height: 10),
            ElevatedButton(onPressed: fetchSentence, child: Text("Next")),
            SizedBox(height: 20),
            Text(result, style: TextStyle(fontSize: 18, color: Colors.deepPurple)),
          ],
        ),
      ),
    );
  }
}
