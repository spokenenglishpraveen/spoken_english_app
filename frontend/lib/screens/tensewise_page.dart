import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TenseWisePage extends StatefulWidget {
  @override
  _TenseWisePageState createState() => _TenseWisePageState();
}

class _TenseWisePageState extends State<TenseWisePage> {
  final List<String> tenses = ['Simple Present', 'Have to'];
  String? selectedTense;
  String teluguSentence = "";
  String englishSentence = "";
  bool showAnswer = false;

  Future<void> fetchSentenceByTense(String tense) async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/get_sentence_by_tense?tense=$tense'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        teluguSentence = data['telugu'];
        englishSentence = data['english'];
        showAnswer = false;
      });
    }
  }

  Widget buildPracticeUI() {
    if (selectedTense == null) return Container();

    return Column(
      children: [
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
            ElevatedButton(onPressed: () => fetchSentenceByTense(selectedTense!), child: Text('Next')),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tense-wise Practice')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: Text("Select Tense"),
              value: selectedTense,
              onChanged: (value) {
                setState(() {
                  selectedTense = value;
                });
                fetchSentenceByTense(value!);
              },
              items: tenses.map((tense) {
                return DropdownMenuItem(value: tense, child: Text(tense));
              }).toList(),
            ),
            SizedBox(height: 20),
            buildPracticeUI(),
          ],
        ),
      ),
    );
  }
}
