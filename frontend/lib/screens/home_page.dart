import 'package:flutter/material.dart';
import 'all_tenses_page.dart';
import 'tensewise_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Spoken English Practice")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Practice All Tenses"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllTensesPage()),
                );
              },
            ),
            ElevatedButton(
              child: Text("Tense-wise Practice"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TenseWisePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

