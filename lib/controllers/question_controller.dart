import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuestionController extends ChangeNotifier {
  List<Question> _questions = [];
  int _current = 0;
  List<Question> get questions => _questions;

  QuestionController({required List<Question> questions}) {
    _questions = questions;
  }

  void answerQuestion(int index, int optionIndex) {
    _questions[index].selectedAnswer = optionIndex;
    notifyListeners();
  }

  void clearAnswer(int index) {
    _questions[index].selectedAnswer = null;
    notifyListeners();
  }

  Question question(int index) {
    return _questions[index];
  }

  set current(int index) {
    _current = index;
    notifyListeners();
  }

  int get current => _current;

  void next() {
    if (_current < _questions.length - 1) {
      _current = _current + 1;
      notifyListeners();
    }
  }

  void prev() {
    if (_current > 0) {
      _current = _current - 1;
      notifyListeners();
    }
  }

  int get length => _questions.length;
}
