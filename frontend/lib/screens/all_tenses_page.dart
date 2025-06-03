import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllTensesPage extends StatefulWidget {
  @override
  _AllTensesPageState createState() => _AllTensesPageState();
}

class _AllTensesPageState extends State<AllTensesPage> {
  String teluguSentence = "";
  String correctEnglish = "";
  String userAnswer = "";
  String result = "";
  bool loading = false;
  String error = "";

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSentence();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchSentence() async {
    setState(() {
      loading = true;
      error = "";
      result = "";
      userAnswer = "";
      _controller.clear();
    });

    try {
      final response = await http
          .get(Uri.parse('https://spoken-english-app-5.onrender.com/get_random_sentence'))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          teluguSentence = data['telugu'];
          correctEnglish = data['english'];
          loading = false;
        });
      } else {
        setState(() {
          error = "Failed to load sentence: ${response.statusCode}";
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = "Error fetching sentence: $e";
        loading = false;
      });
    }
  }

  void checkAnswer() {
    setState(() {
      if (userAnswer.trim().toLowerCase() == correctEnglish.toLowerCase()) {
        result = "✅ Correct!";
      } else {
        result = "❌ Incorrect. Answer: $correctEnglish";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(title: Text("Practice All Tenses")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Practice All Tenses")),
        body: Center(child: Text(error, style: TextStyle(color: Colors.red, fontSize: 18))),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Practice All Tenses")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Translate this sentence:", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(teluguSentence, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Your English Translation"),
              onChanged: (value) {
                userAnswer = value;
              },
              maxLines: 2,
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
