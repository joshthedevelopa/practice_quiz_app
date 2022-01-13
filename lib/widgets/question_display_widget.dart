import 'package:flutter/material.dart';
import 'package:practice_quiz/controllers/question_controller.dart';
import 'package:practice_quiz/models/question_model.dart';

class QuestionDisplay extends StatefulWidget {
  const QuestionDisplay({
    Key? key,
    required this.size,
    required this.controller,
  }) : super(key: key);

  final Size size;
  final QuestionController controller;

  @override
  State<QuestionDisplay> createState() => _QuestionDisplayState();
}

class _QuestionDisplayState extends State<QuestionDisplay> {
  late int totalQuestions;
  //  Values : -1, 0 and 1
  List<ValueNotifier<int>> questionNotifier = [];

  @override
  void initState() {
    super.initState();

    totalQuestions = widget.controller.length;
    for (int i = 0; i < totalQuestions; i++) {
      questionNotifier.add(ValueNotifier(i == 0 ? 0 : 1));
    }

    widget.controller.addListener(() {
      int _selected = widget.controller.current;

      for (var i = 0; i < totalQuestions; i++) {
        if (i < _selected) {
          questionNotifier[i].value = -1;
        } else if (i == _selected) {
          questionNotifier[i].value = 0;
        } else {
          questionNotifier[i].value = 1;
        }
      }
    });
  }

  @override
  void dispose() {
    for (var i = 0; i < totalQuestions; i++) {
      questionNotifier[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double inset = MediaQuery.of(context).viewPadding.top;
    double displacement = widget.size.width;

    return Stack(
      children: [
        for (var q = 0; q < totalQuestions; q++)
          ValueListenableBuilder<int>(
            valueListenable: questionNotifier[q],
            builder: (context, _movementFactor, child) {
              Question _questions = widget.controller.question(q);

              return Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(seconds: 3),
                      curve: const Interval(
                        0.0,
                        0.4,
                        curve: Curves.easeInOutBack,
                      ),
                      top: inset,
                      left: displacement * _movementFactor,
                      right: displacement * -_movementFactor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0).copyWith(top: 24),
                        child: Text(
                          _questions.statement,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ),
                    OptionList(
                      options: _questions.options,
                      onSelected: (List<int> indexes) {
                        widget.controller.answerQuestion(q, indexes.first);
                      },
                      bottom: 60,
                      left: displacement * _movementFactor,
                      right: displacement * -_movementFactor,
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}

class OptionList extends StatefulWidget {
  const OptionList({
    Key? key,
    required this.options,
    this.onSelected,
    this.top,
    this.bottom = 0,
    this.left,
    this.right = 0,
  }) : super(key: key);
  final List<Option> options;
  final ValueChanged<List<int>>? onSelected;
  final double? top, left, right, bottom;

  @override
  _OptionListState createState() => _OptionListState();
}

class _OptionListState extends State<OptionList> {
  late int lenght;
  List<int> selected = [];

  @override
  void initState() {
    super.initState();
    lenght = widget.options.length;
  }

  List<Widget> _widgets() {
    List<Widget> widgets = [];

    for (var o = 0; o < lenght; o++) {
      int _reversedIndex = lenght - o;
      bool _selected = selected.contains(o);

      widgets.add(
        AnimatedPositioned(
          duration: const Duration(seconds: 6),
          curve: Interval(
            0.3 * (0.4 / lenght * (_reversedIndex - 1)),
            0.7 * (0.4 / lenght * _reversedIndex),
            curve: Curves.easeInOutBack,
          ),
          bottom: widget.bottom! * o,
          left: widget.left,
          right: widget.right! + 8.0,
          child: InkResponse(
            onTap: () {
              selected = [o];
              widget.onSelected?.call(selected);
              setState(() {});
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 8.0,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              decoration: BoxDecoration(
                color: _selected ? Colors.white70 : Colors.transparent,
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.options[o].name,
                style: TextStyle(
                  color: _selected ? const Color(0xff00003f) : Colors.white,
                  fontSize: 16.0,
                  fontWeight: _selected ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _widgets(),
    );
  }
}
