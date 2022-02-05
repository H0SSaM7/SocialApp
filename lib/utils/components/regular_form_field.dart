// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class myFormField extends StatelessWidget {
  myFormField({
    Key? key,
    required this.type,
    this.isObscure,
    required this.controller,
    this.onTap,
    this.icon,
    this.title,
    this.readOnly,
    this.validateText,
    this.onChange,
    this.onSubmitted,
    this.suffix,
  }) : super(key: key);
  final TextInputType type;
  final bool? isObscure;
  final TextEditingController controller;
  final Function()? onTap;
  final Widget? icon;

  final String? title;

  final bool? readOnly;

  final String? validateText;

  final Function(String)? onChange;
  Widget? suffix;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: const TextStyle(
          fontSize: 16,
        ),
        onChanged: onChange,
        onFieldSubmitted: onSubmitted,
        readOnly: readOnly ?? false,
        keyboardType: type,
        obscureText: isObscure ?? false,
        controller: controller,
        onTap: onTap,
        validator: (value) {
          if (value!.isEmpty) {
            return validateText;
          } else {
            null;
          }
        },
        decoration: InputDecoration(
          suffixIcon: suffix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          prefixIcon: icon,
          hintText: title,
          labelText: title,
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ));
  }
}
