import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

// Put AppDrawer here, before HomeScreen, so it’s defined before usage
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, // remove default padding on top
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

// -- PracticeAllTensesScreen code here (omitted for brevity), with drawer: AppDrawer()

class PracticeAllTensesScreen extends StatefulWidget {
  @override
  _PracticeAllTensesScreenState createState() => _PracticeAllTensesScreenState();
}

class _PracticeAllTensesScreenState extends State<PracticeAllTensesScreen> {
  // Your variables...

  @override
  void initState() {
    super.initState();
    // fetch initial data
  }

  Future<void> fetchRandomSentence() async {
    setState(() {
      // set loading states
    });

    // fetch from backend
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Practice All Tenses')),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Implement your UI here...'),
      ),
    );
  }
}

// -- Now TenseWisePracticeScreen below --

class TenseWisePracticeScreen extends StatefulWidget {
  @override
  _TenseWisePracticeScreenState createState() => _TenseWisePracticeScreenState();
}

class _TenseWisePracticeScreenState extends State<TenseWisePracticeScreen> {
  String? selectedTense;
  List<String> tenses = ['Simple Present'];

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

    // your fetch code here

    setState(() {
      loading = false;
      // update sentences from backend response
    });
  }

  @override
  void initState() {
    super.initState();
    selectedTense = tenses[0];
    fetchSentenceByTense(selectedTense!);
  }

  @override
  Widget build(BuildContext context) {
    // Your build method implementation here
    return Scaffold(
      appBar: AppBar(title: Text('Tense-wise Practice')),
      drawer: AppDrawer(),
      body: Center(child: Text('Implement your UI here...')),
    );
  }
}
