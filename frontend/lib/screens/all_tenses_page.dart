import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllTensesPage extends StatefulWidget {
  @override
  _AllTensesPageState createState() => _AllTensesPageState();
}

class _AllTensesPageState extends State<AllTensesPage> {
  String telugu = '';
  String english = '';
  String tense = '';

  Future<void> fetchSentence() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/get_random_sentence'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        telugu = data['telugu'];
        english = data['english'];
        tense = data['tense'];
      });
    } else {
      setState(() {
        telugu = 'Error fetching data';
        english = '';
        tense = '';
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
      appBar: AppBar(title: Text('Practice All Tenses')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Tense: $tense', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Translate this Telugu sentence:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(telugu, style: TextStyle(fontSize: 20, color: Colors.blue)),
            SizedBox(height: 30),
            Text('English Answer:', style: TextStyle(fontSize: 16)),
            Text(english, style: TextStyle(fontSize: 20, color: Colors.green)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: fetchSentence,
              child: Text('Next Sentence'),
            )
          ],
        ),
      ),
    );
  }
}
