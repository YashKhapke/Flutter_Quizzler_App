import 'package:flutter/material.dart';
import 'package:quizzler/questionz.dart';
// ignore_for_file: prefer_const_constructors

class QuizBrain {
  int _questionno = 0;

  final List<Questions> _questionbank = [
    Questions(
        s: 'All Lily are flowers. Some flowers are used to make perfumes. Hence, some Lily are used to make perfume',
        b: false),
    Questions(
        s: 'The five rings on the Olympic flag are interlocking', b: true),
    Questions(s: 'The black box in a plane is black', b: false),
  ];
  String getquestiontext() {
    return _questionbank[_questionno].questiontext;
  }

  bool getquestionanswer() {
    return _questionbank[_questionno].questionanswer;
  }

  void click() {
    if (_questionno < _questionbank.length - 1) _questionno++;
  }

  bool isfinished() {
    if (_questionno == _questionbank.length - 1) {
      debugPrint('Now returning true');

      return true;
    } else {
      return false;
    }
  }

  int totalquestions() {
    return _questionbank.length;
  }

  void reset() {
    _questionno = 0;
  }
}
