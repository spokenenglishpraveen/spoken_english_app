import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllTensesPage extends StatefulWidget {
  @override
  _AllTensesPageState createState() => _AllTensesPageState();
}

class _AllTensesPageState extends State<AllTensesPage> {
  String telugu = "";
  String english = "";

  Future<void> fetchSentence() async {
    final response = await http.get(Uri.parse("http://<your-api-url>/get_random_sentence"));
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
    fetchSentence();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Tenses Practice")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Telugu: $telugu"),
            SizedBox(height: 10),
            Text("English: $english"),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Next Sentence"),
              onPressed: fetchSentence,
            ),
          ],
        ),
      ),
    );
  }
}

