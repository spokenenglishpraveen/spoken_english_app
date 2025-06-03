import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllTensesPage extends StatefulWidget {
  @override
  _AllTensesPageState createState() => _AllTensesPageState();
}

class _AllTensesPageState extends State<AllTensesPage> {
  String teluguSentence = "";
  String englishSentence = "";
  String tense = "";
  bool showAnswer = false;

  @override
  void initState() {
    super.initState();
    fetchRandomSentence();
  }

  Future<void> fetchRandomSentence() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/get_random_sentence'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        teluguSentence = data['telugu'];
        englishSentence = data['english'];
        tense = data['tense'];
        showAnswer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Practice All Tenses')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Tense: $tense", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text("Telugu: $teluguSentence", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            if (showAnswer)
              Text("English: $englishSentence", style: TextStyle(fontSize: 20, color: Colors.green)),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () => setState(() => showAnswer = true), child: Text('Show Answer')),
                SizedBox(width: 20),
                ElevatedButton(onPressed: fetchRandomSentence, child: Text('Next')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
