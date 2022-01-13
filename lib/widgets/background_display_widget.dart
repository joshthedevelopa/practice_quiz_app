import 'package:flutter/material.dart';

class BackgroundDisplay extends StatelessWidget {
  const BackgroundDisplay({
    Key? key,
    this.width,
    this.height,
    required this.changeSize,
  }) : super(key: key);

  final double? width;
  final double? height;
  final ValueNotifier<bool> changeSize;

  @override
  Widget build(BuildContext context) {
    double _width = width ?? MediaQuery.of(context).size.width;
    double _height = height ?? MediaQuery.of(context).size.height;

    return ValueListenableBuilder<bool>(
      valueListenable: changeSize,
      builder: (context, _change, child) {
        double topLeft = _width * .3;
        double topRight = _width * .7;
        double midLeft = 80;
        double midRight = 80;
        double bottom = _width * .5;

        if (_change) {
          topLeft = _width * .7;
          topRight = _width * .3;
          midRight = _width * .5;
          midLeft = 90;
          bottom = _width * .4;
        }

        return Stack(
          children: [
            CustomPositioned(
              size: topLeft,
            ),
            CustomPositioned(
              top: 16,
              right: -(topRight * .4),
              size: topRight,
            ),
            CustomPositioned(
              top: _height * .4,
              left: -(midLeft * .5),
              size: midLeft,
            ),
            CustomPositioned(
              top: _height * .5,
              right: _width * .05,
              size: midRight,
            ),
            CustomPositioned(
              bottom: 16,
              size: bottom,
            ),
          ],
        );
      },
    );
  }
}

class CustomPositioned extends StatelessWidget {
  final double? top, left, right, bottom;
  final double size;

  const CustomPositioned({
    Key? key,
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOut,
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 1200),
        height: size,
        width: size,
      ),
    );
  }
}
