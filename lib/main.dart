import "package:flutter/material.dart";
import "package:quizzler/quiz_brain.dart";
import 'package:rflutter_alert/rflutter_alert.dart';
// ignore_for_file: prefer_const_constructors

QuizBrain quizbrain = QuizBrain();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: QuizApp(),
        ),
      ),
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);
  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Icon> scorekeeper = [];
  int correctans = 0;

  void checkanswer(bool myanswer) {
    bool correctanswer = quizbrain.getquestionanswer();
    int answ = quizbrain.totalquestions();
    setState(() {
      if (quizbrain.isfinished() == true) {
        if (correctanswer == myanswer) {
          correctans++;
        }
        Alert(
          context: context,
          title: 'Score = $correctans/$answ',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();
        quizbrain.reset();
        correctans = 0;
        scorekeeper = [];
      } else {
        if (correctanswer == myanswer) {
          scorekeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
          correctans++;
        } else {
          scorekeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizbrain.click();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Center(
              child: Text(
                quizbrain.getquestiontext(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                primary: Colors.white,
              ),
              onPressed: () {
                checkanswer(true);
              },
              child: Text(
                "True",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                primary: Colors.white,
              ),
              onPressed: () {
                checkanswer(false);
              },
              child: Text(
                "False",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: scorekeeper,
        ),
      ],
    );
  }
}
