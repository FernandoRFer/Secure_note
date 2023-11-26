import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppForm extends StatefulWidget {
  final Color? textColor;
  final Color? borderSideColor;
  final String labelText;
  final Color? labelStyleColor;
  final Color? focusedBorderColor;
  final bool isPassword;
  final IconData? icon;
  final String? Function(String?)? validador;
  final void Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const AppForm({
    this.borderSideColor,
    this.textColor,
    this.labelText = " ",
    this.labelStyleColor,
    this.focusedBorderColor,
    this.isPassword = false,
    this.icon,
    this.validador,
    this.onChanged,
    this.inputFormatters,
    this.controller,
    this.keyboardType,
    super.key,
  });

  @override
  State<AppForm> createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  bool senhaVisivel = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged ?? (value) {},
      obscureText: senhaVisivel,
      validator: widget.validador,
      inputFormatters: widget.inputFormatters,
      style: TextStyle(color: widget.textColor),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.borderSideColor ?? const Color(0xFF000000),
                width: 1.0),
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(color: widget.labelStyleColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.focusedBorderColor ?? const Color(0xFF000000),
                  width: 1.0),
              borderRadius: BorderRadius.circular(8)),
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    _setSenhaVisivel();
                  },
                  child: senhaVisivel
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off))
              : Icon(widget.icon)),
    );
  }

  void _setSenhaVisivel() {
    setState(() {
      senhaVisivel = !senhaVisivel;
    });
  }
}

class AppFormText extends StatefulWidget {
  final Color? textColor;
  final Color? borderSideColor;
  final String labelText;
  final Color? labelStyleColor;
  final Color? focusedBorderColor;
  final bool isPassword;
  final IconData? icon;
  final String? Function(String?)? validador;
  final void Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLines;

  const AppFormText({
    this.borderSideColor,
    this.textColor,
    this.labelText = " ",
    this.labelStyleColor,
    this.focusedBorderColor,
    this.isPassword = false,
    this.icon,
    this.validador,
    this.onChanged,
    this.inputFormatters,
    this.controller,
    this.keyboardType,
    this.maxLines,
    super.key,
  });

  @override
  State<AppFormText> createState() => _AppFormTexteState();
}

class _AppFormTexteState extends State<AppFormText> {
  bool senhaVisivel = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLines: widget.maxLines,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged ?? (value) {},
        obscureText: senhaVisivel,
        validator: widget.validador,
        inputFormatters: widget.inputFormatters,
        style: TextStyle(color: widget.textColor),
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  //  color: Color.fromARGB(0, 0, 0, 0),
                  ),
            ),
            labelText: widget.labelText,
            labelStyle: TextStyle(color: widget.labelStyleColor),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromARGB(0, 0, 0, 0), width: 1.0),
            )));
  }
}
