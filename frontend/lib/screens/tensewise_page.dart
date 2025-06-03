import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TenseWisePage extends StatefulWidget {
  @override
  _TenseWisePageState createState() => _TenseWisePageState();
}

class _TenseWisePageState extends State<TenseWisePage> {
  List<String> tenses = [];
  String selectedTense = "";
  String teluguSentence = "";
  String correctEnglish = "";
  String userAnswer = "";
  String result = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTenses();
  }

  Future<void> fetchTenses() async {
    final response = await http.get(Uri.parse('https://spoken-english-app-5.onrender.com/get_all_tenses'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print("Fetched tenses: $data"); // 🐛 Debug print

      setState(() {
        tenses = List<String>.from(data);
        selectedTense = tenses.first;
        isLoading = false;
      });

      fetchSentence();
    } else {
      print("Failed to fetch tenses");
      setState(() {
        tenses = ["Simple Present"];
        selectedTense = "Simple Present";
        isLoading = false;
      });
    }
  }

  Future<void> fetchSentence() async {
    final response = await http.get(Uri.parse(
        'https://spoken-english-app-5.onrender.com/get_sentence_by_tense?tense=${Uri.encodeComponent(selectedTense)}'));

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
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Tense-wise Practice")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
