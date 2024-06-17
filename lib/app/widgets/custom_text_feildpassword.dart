/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPassword extends StatefulWidget {
  const CustomPassword({super.key});

  @override
  State<CustomPassword> createState() => _CustomPasswordState();
}

class _CustomPasswordState extends State<CustomPassword> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      obscureText: _obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.text,
        prefixIcon: widget.prefixIcon,
        suffixIcon: IconButton(
          icon: widget.suffixIcon!,
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText; // Toggle th e visibility of the password text
            });
          },
        ),
      ),
      validator: widget.validator,
    );
  }
  }
}
*/
