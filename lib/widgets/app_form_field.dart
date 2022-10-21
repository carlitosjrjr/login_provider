import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  final String name;
  final String label;
  final IconData? icon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;

  const AppFormField(
    this.name,
    this.label,
    this.keyboardType,
    this.textInputAction, {
    Key? key,
    this.icon,
    this.validator,
    this.controller,
    this.obscureText = false,
    required this.formData,
  }) : super(key: key);

  final Map<String, String> formData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        onChanged: (value) {
          formData[name] = value;
        },
        obscureText: obscureText,
        validator: validator,
        autofocus: true,
        keyboardType: keyboardType,
        decoration: InputDecoration(icon: Icon(icon), hintText: label),
        textInputAction: textInputAction);
  }
}
