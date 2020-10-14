import 'package:flutter/material.dart';
import 'package:pet_adoption/constants.dart';

Widget inputField({Function(String) onSubmit,TextInputType textInputType,String hint,Function(String) validator,IconData icon,Function(String) onSaved}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: TextFormField(
      keyboardType: textInputType,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          isDense: true,
          suffixIcon: Icon(
            icon,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: kPrimaryColor,width: 0.3),
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
      onFieldSubmitted: onSubmit,
    ),
  );
}