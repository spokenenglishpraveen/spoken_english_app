import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TenseWisePage extends StatefulWidget {
  @override
  _TenseWisePageState createState() => _TenseWisePageState();
}

class _TenseWisePageState extends State<TenseWisePage> {
  String selectedTense = "Simple Present";
  String telugu = "";
  String english = "";

  List<String> tenses = ["Simple Present" /*, Add more */];

  Future<void> fetchTenseSentence() async {
    final response = await http.get(Uri.parse("http://<your-api-url>/get_sentence_by_tense?tense=$selectedTense"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        telugu = data['telugu'];
        english = data['english'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTenseSentence();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tense-wise Practice")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedTense,
              onChanged: (value) {
                setState(() {
                  selectedTense = value!;
                  fetchTenseSentence();
                });
              },
              items: tenses.map((String tense) {
                return DropdownMenuItem(value: tense, child: Text(tense));
              }).toList(),
            ),
            SizedBox(height: 20),
            Text("Telugu: $telugu"),
            SizedBox(height: 10),
            Text("English: $english"),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Next"),
              onPressed: fetchTenseSentence,
            ),
          ],
        ),
      ),
    );
  }
}

