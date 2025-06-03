import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

// Change this to your deployed Flask backend URL
const String baseUrl = 'https://spoken-english-app-5.onrender.com';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Practice All Tenses'),
            onTap: () => Navigator.pushReplacementNamed(context, '/all_tenses'),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Tense-wise Practice'),
            onTap: () => Navigator.pushReplacementNamed(context, '/tense_wise'),
          ),
        ],
      ),
    );
  }
}

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
      appBar: AppBar(title: Text('Tense Practice Home')),
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
  _PracticeAllTensesScreenState createState() => _PracticeAllTensesScreenState();
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

    try {
      final response = await http
          .get(Uri.parse('$baseUrl/get_random_sentence'))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          tense = data['tense'];
          teluguSentence = data['telugu'];
          englishSentence = data['english'];
          loading = false;
        });
      } else {
        setState(() {
          teluguSentence = 'Error loading sentence (status: ${response.statusCode})';
          englishSentence = '';
          loading = false;
        });
      }
    } catch (e) {
      print('Error fetching random sentence: $e');
      setState(() {
        teluguSentence = 'Failed to load sentence: $e';
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
      appBar: AppBar(title: Text('Practice All Tenses')),
      drawer: AppDrawer(),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : (teluguSentence == null || teluguSentence!.startsWith('Error') || teluguSentence!.startsWith('Failed'))
              ? Center(child: Text(teluguSentence ?? 'Unknown error'))
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
                        onChanged: (val) => userAnswer = val,
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
                              fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
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
  _TenseWisePracticeScreenState createState() => _TenseWisePracticeScreenState();
}

class _TenseWisePracticeScreenState extends State<TenseWisePracticeScreen> {
  String? selectedTense;
  List<String> tenses = [
    'Simple Present', 'Simple Past', 'Simple Future', 'Present Continuous',
    'Past Continuous', 'Future Continuous', 'Present Perfect', 'Want to',
    'Wanted to', 'Present Be Forms', 'Past Be Forms', 'Future Be Forms', 'Have to'
  ];

  String? teluguSentence;
  String? englishSentence;
  bool showAnswer = false;
  bool loading = false;
  String userAnswer = '';

  Future<void> fetchSentenceByTense(String tense) async {
    setState(() {
      loading = true;
      showAnswer = false;
      userAnswer = '';
    });

    try {
      final response = await http
          .get(Uri.parse('$baseUrl/get_sentence_by_tense?tense=$tense'))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          teluguSentence = data['telugu'];
          englishSentence = data['english'];
          loading = false;
        });
      } else {
        setState(() {
          teluguSentence = 'Error loading sentence (status: ${response.statusCode})';
          englishSentence = '';
          loading = false;
        });
      }
    } catch (e) {
      print('Error fetching sentence by tense: $e');
      setState(() {
        teluguSentence = 'Failed to load sentence: $e';
        englishSentence = '';
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedTense = tenses[0];
    fetchSentenceByTense(selectedTense!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tense-wise Practice')),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedTense,
              items: tenses
                  .map((tense) => DropdownMenuItem(
                        value: tense,
                        child: Text(tense),
                      ))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    selectedTense = val;
                  });
                  fetchSentenceByTense(val);
                }
              },
            ),
            SizedBox(height: 20),
            loading
                ? Center(child: CircularProgressIndicator())
                : (teluguSentence == null || teluguSentence!.startsWith('Error') || teluguSentence!.startsWith('Failed'))
                    ? Center(child: Text(teluguSentence ?? 'Unknown error'))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Translate to Telugu:', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 10),
                          Text(
                            englishSentence ?? '',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            onChanged: (val) => userAnswer = val,
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
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  fetchSentenceByTense(selectedTense!);
                                },
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
          ],
        ),
      ),
    );
  }
}
