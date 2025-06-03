import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TenseWisePage extends StatefulWidget {
  @override
  _TenseWisePageState createState() => _TenseWisePageState();
}

class _TenseWisePageState extends State<TenseWisePage> {
  String selectedTense = "Simple Present";
  String telugu = '';
  String english = '';

  List<String> tenses = ["Simple Present", "Have to"];

  Future<void> fetchSentenceByTense(String tense) async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/get_sentence_by_tense?tense=$tense'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        telugu = data['telugu'];
        english = data['english'];
      });
    } else {
      setState(() {
        telugu = 'Error fetching data';
        english = '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSentenceByTense(selectedTense);
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
              value: selectedTense,
              items: tenses.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedTense = newValue!;
                  fetchSentenceByTense(selectedTense);
                });
              },
            ),
            SizedBox(height: 20),
            Text('Translate this:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(telugu, style: TextStyle(fontSize: 20, color: Colors.blueAccent)),
            SizedBox(height: 30),
            Text('Answer:', style: TextStyle(fontSize: 16)),
            Text(english, style: TextStyle(fontSize: 20, color: Colors.green)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => fetchSentenceByTense(selectedTense),
              child: Text('Next Sentence'),
            )
          ],
        ),
      ),
    );
  }
}
