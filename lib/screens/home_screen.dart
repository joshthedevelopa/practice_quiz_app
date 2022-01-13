import 'package:flutter/material.dart';
import 'package:practice_quiz/controllers/question_controller.dart';
import 'package:practice_quiz/utilities/data.dart';
import '../widgets/question_display_widget.dart';
import '../widgets/sidebar_widget.dart';
import '../widgets/background_display_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double left = 24.0;
  final ValueNotifier<bool> questionChanged = ValueNotifier(false);
  late final QuestionController _questionController;

  @override
  void initState() {
    super.initState();

    _questionController = QuestionController(questions: questions);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      color: const Color(0xff00003f),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: BackgroundDisplay(
              changeSize: questionChanged,
            ),
          ),
          Positioned(
            top: 0,
            left: left,
            bottom: 16,
            right: 0,
            child: AnimatedSidebar(
              controller: _questionController,
            ),
          ),
          Positioned(
            top: 0,
            left: left + 20,
            right: 0,
            // 76
            bottom: 72,
            child: QuestionDisplay(
              size: size,
              controller: _questionController,
            ),
          ),
          Positioned(
            left: left + 30,
            right: 16.0,
            bottom: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButton(
                  icon: Icons.arrow_back_ios,
                  action: () {
                    _questionController.prev();
                    questionChanged.value = !questionChanged.value;

                  },
                ),
                ActionButton(
                  icon: Icons.arrow_forward_ios,
                  action: () {
                    _questionController.next();
                    questionChanged.value = !questionChanged.value;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.action,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? action;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(1000),
      onTap: action,
      child: SizedBox(
        width: 60,
        height: 60,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
