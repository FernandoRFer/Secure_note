// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:angles/angles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class Successs {
  appShowDialog({
    String title = "",
    String subtitle = "",
    List<Widget>? buttons,
    required bool isDismissible,
    required BuildContext context,
    bool enableDrag = false,
    bool isClosingWithTime = true,
    Function()? button,
  }) {
    return showDialog(
        barrierColor: Theme.of(context).colorScheme.surfaceVariant,
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return TweenAnimationBuilder<Duration>(
              duration: const Duration(seconds: 3),
              tween:
                  Tween(begin: const Duration(seconds: 3), end: Duration.zero),
              onEnd: button,
              builder: (BuildContext context, Duration value, Widget? child) {
                return GestureDetector(
                  onTap: button,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: AnimatedCheck(),
                                ),
                                // SizedBox(
                                //   height: 150,
                                //   child: Lottie.asset(
                                //     "assets/lottie/confirmation-tick.json",
                                //     repeat: true,
                                //   ),
                                // ),
                                Container(
                                  padding: const EdgeInsets.only(top: 14),
                                  child: Text(
                                    title,
                                  ),
                                ),
                                subtitle == ""
                                    ? Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 5, 20, 5),
                                        child: Text(
                                          subtitle,
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                        // ...?buttons
                      ],
                    ),
                  ),
                );
              });
        });
  }
}

class AnimatedCheck extends StatefulWidget {
  const AnimatedCheck({Key? key}) : super(key: key);

  @override
  _AnimatedCheckState createState() => _AnimatedCheckState();
}

class _AnimatedCheckState extends State<AnimatedCheck>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> curve;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    curve = CurvedAnimation(parent: _controller, curve: Curves.linear);

    _controller.addListener(
      () {
        setState(() {});
      },
    );

    Timer(const Duration(milliseconds: 200), () => _controller.forward());
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: AuxPainter(curve.value, context),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: 1.0 * curve.value,
        child: Icon(
          FontAwesomeIcons.check,
          color: Theme.of(context).colorScheme.primary,
          size: 50,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AuxPainter extends CustomPainter {
  late Paint _paint;
  double value;
  BuildContext context;
  late final Color _colors = Theme.of(context).colorScheme.primary;

  AuxPainter(
    this.value,
    this.context,
  ) {
    _paint = Paint()
      ..color = _colors
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var rect = const Offset(0, 0) & size;
    // _paint.color = AppTheme.successColor;

    var an = 360.0 * value;

    canvas.drawArc(rect, 0, Angle.degrees(an).radians, false, _paint);
  }

  @override
  bool shouldRepaint(AuxPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
