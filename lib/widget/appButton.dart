import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  final Color iconColor;

  final String text;
  final void Function()? onPressed;
  //final bool reduceSize;
  final IconData? icon;

  const AppOutlinedButton(this.text,
      {this.onPressed,
      super.key,
      this.iconColor = const Color.fromARGB(255, 0, 0, 0),
      //this.reduceSize = false,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8),
        ),
        height: 48,
        child: icon == null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                child: Center(
                    child: Text(
                  text,
                )),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: iconColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    text,
                  ),
                ],
              ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final Color? iconColor;
  final Color? color;
  final String text;
  final void Function()? onPressed;
  final IconData? icon;

  const AppButton(
    this.text, {
    this.onPressed,
    super.key,
    //this.reduceSize = false,
    this.icon,
    this.iconColor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        height: 48,
        child: icon == null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                child: Center(
                    child: Text(
                  text,
                )),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: iconColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    text,
                  ),
                ],
              ),
      ),
    );
  }
}
