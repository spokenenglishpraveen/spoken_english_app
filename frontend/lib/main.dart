import 'package:flutter/material.dart';

void main() {
  runApp(PracticeApp());
}

class PracticeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practice Verbs',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PracticeHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PracticeHomePage extends StatefulWidget {
  @override
  _PracticeHomePageState createState() => _PracticeHomePageState();
}

class _PracticeHomePageState extends State<PracticeHomePage> {
  // Sample data for practice
  final List<Map<String, String>> verbs = [
    {
      'telugu': 'చదువు',
      'english': 'study',
      'past': 'studied',
      'present_participle': 'studying',
      'example_telugu': 'నేను చదువుతున్నాను',
      'example_english': 'I am studying',
    },
    {
      'telugu': 'రాయడం',
      'english': 'write',
      'past': 'wrote',
      'present_participle': 'writing',
      'example_telugu': 'అవను లేఖ రాస్తున్నాడు',
      'example_english': 'He is writing a letter',
    },
    // Add more verbs here...
  ];

  int currentIndex = 0;
  final TextEditingController answerController = TextEditingController();
  String feedback = '';
  bool showAnswer = false;

  void nextVerb() {
    setState(() {
      feedback = '';
      showAnswer = false;
      answerController.clear();
      currentIndex = (currentIndex + 1) % verbs.length;
    });
  }

  void previousVerb() {
    setState(() {
      feedback = '';
      showAnswer = false;
      answerController.clear();
      currentIndex = (currentIndex - 1 + verbs.length) % verbs.length;
    });
  }

  void checkAnswer() {
    String userAnswer = answerController.text.trim().toLowerCase();
    String correctAnswer = verbs[currentIndex]['english']!.toLowerCase();

    setState(() {
      if (userAnswer == correctAnswer) {
        feedback = 'Correct!';
      } else {
        feedback = 'Incorrect! Try again or press Show Answer.';
      }
    });
  }

  void toggleShowAnswer() {
    setState(() {
      showAnswer = !showAnswer;
      feedback = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentVerb = verbs[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Practice Verbs')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Translate this Telugu verb into English:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 12),
            Text(
              currentVerb['telugu']!,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            TextField(
              controller: answerController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Answer',
              ),
            ),
            SizedBox(height: 12),
            Text(
              feedback,
              style: TextStyle(
                fontSize: 18,
                color: feedback == 'Correct!' ? Colors.green : Colors.red,
              ),
            ),
            if (showAnswer)
              Card(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Answer: ${currentVerb['english']}', style: TextStyle(fontSize: 20)),
                      SizedBox(height: 8),
                      Text('Past form: ${currentVerb['past']}'),
                      Text('Present Participle: ${currentVerb['present_participle']}'),
                      SizedBox(height: 12),
                      Text('Example (Telugu): ${currentVerb['example_telugu']}'),
                      Text('Example (English): ${currentVerb['example_english']}'),
                    ],
                  ),
                ),
              ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: previousVerb, child: Text('Previous')),
                ElevatedButton(onPressed: checkAnswer, child: Text('Check Answer')),
                ElevatedButton(onPressed: toggleShowAnswer, child: Text(showAnswer ? 'Hide Answer' : 'Show Answer')),
                ElevatedButton(onPressed: nextVerb, child: Text('Next')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
