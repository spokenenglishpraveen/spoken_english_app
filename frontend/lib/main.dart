import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TranslationPractice extends StatefulWidget {
  @override
  _TranslationPracticeState createState() => _TranslationPracticeState();
}

class _TranslationPracticeState extends State<TranslationPractice> {
  int currentSentenceId = 1;
  String englishSentence = '';
  String userTranslation = '';
  String resultMessage = '';

  final String backendUrl = 'http://YOUR_BACKEND_IP_OR_DOMAIN:5000';

  @override
  void initState() {
    super.initState();
    fetchSentence();
  }

  Future<void> fetchSentence() async {
    final response = await http.get(Uri.parse('$backendUrl/sentence/$currentSentenceId'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        englishSentence = data['english'];
        userTranslation = '';
        resultMessage = '';
      });
    } else {
      setState(() {
        englishSentence = 'No sentence found';
      });
    }
  }

  Future<void> checkAnswer() async {
    final response = await http.post(
      Uri.parse('$backendUrl/check_answer'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': currentSentenceId,
        'translation': userTranslation,
      }),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        if (data['correct']) {
          resultMessage = 'Correct! 🎉';
        } else {
          resultMessage = 'Wrong. Correct answer: ${data['correct_answer']}';
        }
      });
    } else {
      setState(() {
        resultMessage = 'Error checking answer.';
      });
    }
  }

  void nextSentence() {
    setState(() {
      currentSentenceId += 1;
      resultMessage = '';
    });
    fetchSentence();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('English to Telugu Practice')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Translate to Telugu:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(englishSentence, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) => userTranslation = value,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Telugu translation',
              ),
              maxLines: 2,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: checkAnswer,
                  child: Text('Check Answer'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: nextSentence,
                  child: Text('Next Sentence'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(resultMessage, style: TextStyle(fontSize: 18, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
