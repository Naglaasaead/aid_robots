import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldPhone extends TextFormField {
  CustomTextFieldPhone({
    Key? key,
    required String text,
    required FormFieldValidator<String> validator,
  }) : super(
    key: key,
    obscureText: false,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
    ],
    decoration: InputDecoration(
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(0),
      ),
      border: OutlineInputBorder(

        borderRadius: BorderRadius.circular(10),

      ),
      hintText: text,

    ),
    validator: validator,
    keyboardType: TextInputType.number,
  );
}