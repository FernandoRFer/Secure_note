// import 'dart:async';

// import 'package:angles/angles.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:pos/theme.dart';

// class SuccessViewArguments {
//   final String? title;
//   final String? message;
//   final List<Widget>? buttons;
//   final bool showCloseButton;
//   final void Function() onClose;
//   SuccessViewArguments({
//     this.title,
//     this.message,
//     this.buttons,
//     this.showCloseButton = true,
//     required this.onClose,
//   });
// }

// class SuccessView extends StatefulWidget {
//   const SuccessView({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _SuccessViewState createState() => _SuccessViewState();
// }

// class _SuccessViewState extends State<SuccessView>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> curve;

//   @override
//   void initState() {
//     super.initState();

//     _controller =
//         AnimationController(duration: const Duration(seconds: 2), vsync: this);
//     curve = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

//     _controller.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     SuccessViewArguments args =
//         ModalRoute.of(context)!.settings.arguments as SuccessViewArguments;

//     List<Widget> buttons = [];

//     if (args.showCloseButton) {
//       buttons.add(AppOutlinedButton(
//         "Ok",
//         color: AppColor.purple,
//         onPressed: () async {
//           args.onClose();
//         },
//       ));
//     }

//     if (args.buttons != null) buttons.addAll(args.buttons!);

//     return Scaffold(
//       body: AppScreenPadding(
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     const SizedBox(
//                       height: 100,
//                       width: 100,
//                       child: AnimatedCheck(),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.only(top: 14),
//                       child: AppText(
//                         args.title ?? "",
//                         fontSize: AppFontSize.heading2,
//                         fontWeight: AppFontWeight.normal,
//                         fontColor: AppColor.black,
//                         align: TextAlign.center,
//                         key: const Key("Title"),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
//                       child: AppText(
//                         args.message ?? "",
//                         key: const Key("message"),
//                         fontColor: AppColor.grey,
//                         fontSize: AppFontSize.heading5,
//                         fontWeight: AppFontWeight.normal,
//                         align: TextAlign.center,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             ...buttons
//           ],
//         ),
//       ),
//     );
//   }

//   // _snackBar(BuildContext context, String message) {
//   //   SnackBarHelper.showSnackBar(context, message);
//   // }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// class AnimatedCheck extends StatefulWidget {
//   const AnimatedCheck({Key? key}) : super(key: key);

//   @override
//   _AnimatedCheckState createState() => _AnimatedCheckState();
// }

// class _AnimatedCheckState extends State<AnimatedCheck>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> curve;
//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//         duration: const Duration(milliseconds: 300), vsync: this);
//     curve = CurvedAnimation(parent: _controller, curve: Curves.linear);

//     _controller.addListener(
//       () {
//         setState(() {});
//       },
//     );

//     Timer(const Duration(milliseconds: 200), () => _controller.forward());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: AuxPainter(curve.value),
//       child: AnimatedOpacity(
//         duration: const Duration(milliseconds: 300),
//         opacity: 1.0 * curve.value,
//         child: const Icon(
//           FontAwesomeIcons.check,
//           color: AppTheme.successColor,
//           size: 50,
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// class AuxPainter extends CustomPainter {
//   late Paint _paint;
//   double value;

//   AuxPainter(this.value) {
//     _paint = Paint()
//       ..color = AppTheme.successColor
//       ..strokeWidth = 5.0
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke;
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     var rect = const Offset(0, 0) & size;
//     _paint.color = AppTheme.successColor;

//     var an = 360.0 * value;

//     canvas.drawArc(rect, 0, Angle.degrees(an).radians, false, _paint);
//   }

//   @override
//   bool shouldRepaint(AuxPainter oldDelegate) {
//     return oldDelegate.value != value;
//   }
// }
