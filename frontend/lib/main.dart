import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

// Base URL for your Flask backend (change to your deployed URL)
const String baseUrl = 'http://YOUR_FLASK_BACKEND_URL';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tense Practice',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      routes: {
        '/all_tenses': (_) => PracticeAllTensesScreen(),
        '/tense_wise': (_) => TenseWisePracticeScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tense Practice Home')),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Practice All Tenses'),
              onPressed: () => Navigator.pushNamed(context, '/all_tenses'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Tense-wise Practice'),
              onPressed: () => Navigator.pushNamed(context, '/tense_wise'),
            ),
          ],
        ),
      ),
    );
  }
}

class PracticeAllTensesScreen extends StatefulWidget {
  @override
  _PracticeAllTensesScreenState createState() =>
      _PracticeAllTensesScreenState();
}

class _PracticeAllTensesScreenState extends State<PracticeAllTensesScreen> {
  String? teluguSentence;
  String? englishSentence;
  String? tense;
  String userAnswer = '';
  bool showAnswer = false;
  bool loading = true;

  Future<void> fetchRandomSentence() async {
    setState(() {
      loading = true;
      showAnswer = false;
      userAnswer = '';
    });

    final response = await http.get(Uri.parse('$baseUrl/get_random_sentence'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        tense = data['tense'];
        teluguSentence = data['telugu'];
        englishSentence = data['english'];
        loading = false;
      });
    } else {
      // Handle error
      setState(() {
        teluguSentence = 'Error loading sentence';
        englishSentence = '';
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRandomSentence();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice All Tenses'),
      ),
      drawer: AppDrawer(),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Tense: $tense', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 20),
                  Text('Translate to Telugu:', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text(
                    englishSentence ?? '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    onChanged: (val) {
                      userAnswer = val;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your Telugu Translation',
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 10),
                  if (showAnswer)
                    Text(
                      'Correct Answer:\n$teluguSentence',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: fetchRandomSentence,
                        child: Text('Next Sentence'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showAnswer = true;
                          });
                        },
                        child: Text('Show Answer'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Simple check ignoring case & whitespace
                          if (userAnswer.trim() == teluguSentence?.trim()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Correct!')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Try Again!')),
                            );
                          }
                        },
                        child: Text('Check Answer'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

class TenseWisePracticeScreen extends StatefulWidget {
  @override
  _TenseWisePracticeScreenState createState() =>
      _TenseWisePracticeScreenState();
}

class _TenseWisePracticeScreenState extends State<TenseWisePracticeScreen> {
  String? selectedTense;
  List<String> tenses = [
    'Simple Present',
    // Add other tenses your backend supports
  ];

  String? teluguSentence;
  String? englishSentence;
  bool showAnswer = false;
  bool loading = false;
  String userAnswer = '';

  Future<void> fetchSentenceByTense(String tense) async {
    setState(() {
      loading = true;
