import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_adoption/constants.dart';

Widget inputField({
  Function(String) onSubmit,
  TextInputType textInputType,
  String hint,
  Function(String) validator,
  IconData icon,
  Function(String) onSaved,
  int counter,
  Function(String) onChanged,
  TextEditingController controller,
  TextInputAction textInputAction = TextInputAction.done,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: TextFormField(
      enableSuggestions: true,
      textInputAction: textInputAction,
      controller: controller,
      maxLength: 200,
      obscureText: hint.contains('*'),
      obscuringCharacter: '*',
      maxLines: counter != null ? 5 : 1,
      keyboardType: textInputType,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(fontSize: 13.5),
        isDense: true,
        suffixIcon: Icon(
          icon,
        ),
        counter: counter == null ? Container(width: 1,) : Text('$counter / 200',),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: kPrimaryColor, width: 0.3),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      onSaved: onSaved,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
    ),
  );
}
