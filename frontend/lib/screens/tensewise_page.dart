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
  bool isSentenceLoading = false;
  String error = "";

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchTenses();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchTenses() async {
    setState(() {
      isLoading = true;
      error = "";
    });

    try {
      final response = await http
          .get(Uri.parse('https://spoken-english-app-5.onrender.com/get_all_tenses'))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          tenses = List<String>.from(data);
          selectedTense = tenses.isNotEmpty ? tenses.first : "";
          isLoading = false;
        });
        if (selectedTense.isNotEmpty) {
          fetchSentence();
        }
      } else {
        setState(() {
          error = "Failed to fetch tenses: ${response.statusCode}";
          tenses = ["Simple Present"];
          selectedTense = "Simple Present";
          isLoading = false;
        });
        fetchSentence();
      }
    } catch (e) {
      setState(() {
        error = "Error fetching tenses: $e";
        tenses = ["Simple Present"];
        selectedTense = "Simple Present";
        isLoading = false;
      });
      fetchSentence();
    }
  }

  Future<void> fetchSentence() async {
    setState(() {
      isSentenceLoading = true;
      error = "";
      result = "";
      userAnswer = "";
      _controller.clear();
    });

    try {
      final response = await http.get(Uri.parse(
          'https://spoken-english-app-5.onrender.com/get_sentence_by_tense?tense=${Uri.encodeComponent(selectedTense)}')).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          teluguSentence = data['telugu'] ?? '';
          correctEnglish = data['english'] ?? '';
          isSentenceLoading = false;
        });
      } else {
        setState(() {
          error = "Failed to load sentence: ${response.statusCode}";
          teluguSentence = "";
          correctEnglish = "";
          isSentenceLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = "Error fetching sentence: $e";
        teluguSentence = "";
        correctEnglish = "";
        isSentenceLoading = false;
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
            if (error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(error, style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
            DropdownButton<String>(
              value: selectedTense,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedTense = value;
                  });
                  fetchSentence();
                }
              },
              items: tenses.map((tense) {
                return DropdownMenuItem(
                  value: tense,
                  child: Text(tense),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            if (isSentenceLoading)
              Center(child: CircularProgressIndicator())
            else ...[
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
            ]
          ],
        ),
      ),
    );
  }
}
