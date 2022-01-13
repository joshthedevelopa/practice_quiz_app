import 'package:flutter/material.dart';
import 'package:practice_quiz/controllers/question_controller.dart';

class AnimatedSidebar extends StatelessWidget {
  const AnimatedSidebar({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final QuestionController controller;

  @override
  Widget build(BuildContext context) {
    double size = 20;
    double barSize = size / 3;

    return LayoutBuilder(builder: (
      BuildContext context,
      BoxConstraints constraints,
    ) {
      return Stack(
        children: [
          Positioned(
            top: 0,
            //Center for Bar : (size * .5) - (barSize * .5)
            left: ((size - barSize) * .5),
            bottom: 0,
            child: SizedBox(
              height: double.infinity,
              width: barSize,
              child: Material(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return AnimatedPoints(
                  selected: controller.current,
                  total: controller.length,
                  height: constraints.maxHeight,
                  size: size,
                );
              }),
          Positioned(
            bottom: 8,
            child: SizedBox(
              width: size,
              height: size,
              child: const Material(
                shape: CircleBorder(),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class AnimatedPoints extends StatelessWidget {
  const AnimatedPoints({
    Key? key,
    required this.selected,
    required this.total,
    required this.height,
    required this.size,
  }) : super(key: key);

  final int selected;
  final int total;
  final double height, size;

  @override
  Widget build(BuildContext context) {
    double inset = MediaQuery.of(context).viewPadding.top;
    double pointSize = size * .7;
    double _bottom = height - (inset + pointSize);
    double upperPoint = _bottom - 50;
    double lowerPoint = 8;

    return Stack(
      children: [
        for (int i = 0; i < total; i++)
          Builder(
            builder: (context) {
              double _point = lowerPoint;
              int _duration = 2;

              if (i < selected) {
                _point = height;
              } else if (i == selected) {
                _point = upperPoint;
              } else {
                _point = lowerPoint;
              }

              return AnimatedPositioned(
                duration: Duration(seconds: _duration),
                curve: Curves.elasticOut,
                bottom: _point,
                // Center for Point : (size * .5) - ((size * .8) * .5)
                left: (size * .15),
                child: SizedBox(
                  width: pointSize,
                  height: pointSize,
                  child: const Material(
                    color: Colors.white,
                    shape: CircleBorder(),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
