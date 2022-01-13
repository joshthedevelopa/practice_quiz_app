
class Option {
  final int id;
  final String name;

  Option(this.id, this.name);
}

enum ChoiceType {
  multiple,
  dual,
  subjective,
}

class Question {
  final int id;
  final String statement;
  final List<Option> options;
  final ChoiceType type;
  final int correctAnswer;
  int? selectedAnswer;

  Question({
    required this.id,
    required this.statement,
    required this.options,
    required this.correctAnswer,
    this.selectedAnswer,
    this.type = ChoiceType.multiple,
  });
}
