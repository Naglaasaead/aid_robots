/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    required this.text,
    required this.validator,
    this.keyboardType, // تحديد keyboardType كاختياري
    required List<FilteringTextInputFormatter> inputFormatters
  }) : super(key: key);

  final String text;
  final FormFieldValidator<String> validator;
  final TextInputType? keyboardType; // تحديد keyboardType كاختياري
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType, // استخدام keyboardType فقط إذا تم تعيينه
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp('[\\s]')),
      ],
      obscureText: _obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.text,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: widget.validator,
    );
  }
}
*/
/*










import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    required this.text,
    required this.validator,
    this.keyboardType,
    this.icon,
    required List<FilteringTextInputFormatter> inputFormatters
  }) : super(key: key);

  final String text;
  final FormFieldValidator<String> validator;
  final TextInputType? keyboardType; // تحديد keyboardType كاختياري
  final Icon? icon; // تحديد الأيقونة كاختيارية
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType, // استخدام keyboardType فقط إذا تم تعيينه
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp('[\\s]')),
      ],
      obscureText: _obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.text,

        suffixIcon: widget.icon != null ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ) : null, // استخدام الأيقونة فقط إذا تم تعيينها
      ),
      validator: widget.validator,
    );
  }
}

*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    required this.text,

    required this.validator,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    required List<FilteringTextInputFormatter> inputFormatters,
    this.obscureText = false, required Null Function(dynamic value) onChanged,
    required this.controller, // تحديد قيمة افتراضية لـ obscureText
  }) : super(key: key);

  final String text;
  final FormFieldValidator<String> validator;
  final TextInputType? keyboardType;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController controller;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText && !_showPassword,
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.text,

        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText ? GestureDetector(
          onTap: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
          child: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
          ),
        ) : null,
      ),
      validator: widget.validator,
    );
  }
}
