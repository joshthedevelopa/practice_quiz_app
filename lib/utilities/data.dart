

import 'package:practice_quiz/models/question_model.dart';

List<Question> questions = [
    Question(
      id: 1,
      statement: "What's the capital of Britian?",
      correctAnswer: 1,
      options: [
        Option(1, "London"),
        Option(2, "Accra"),
        Option(3, "Wakanda"),
      ],
    ),
    Question(
      id: 2,
      statement: "Which of the frameworks below is a mobile cross platform framework?",
      correctAnswer: 1,
      options: [
        Option(1, "Flutter"),
        Option(2, "Laravel"),
        Option(3, "Django"),
      ],
    ),
    Question(
      id: 3,
      statement: "Object Oriented Programming comprises of terminologies such as Abstraction, Polymorphism, Inheritance and Hacking.",
      type: ChoiceType.dual,
      correctAnswer: 2,
      options: [
        Option(1, "True"),
        Option(2, "False"),
      ],
    ),
    Question(
      id: 4,
      statement: "Which programming language is React built in?",
      correctAnswer: 3,
      options: [
        Option(1, "German"),
        Option(2, "Sign Language"),
        Option(3, "Javascript"),
        Option(4, "Python"),
      ],
    ),
  ];