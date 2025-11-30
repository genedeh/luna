import 'package:flutter/material.dart';

class CustomInputFieldWidget extends StatelessWidget {
  final String label;
  final String? helper;
  final bool obscure;
  final TextEditingController controller;
  final String? Function(String?) validator;

  final Widget? suffixIcon;

  const CustomInputFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    this.helper,
    this.obscure = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          labelText: label,
          helperText: helper,
          errorStyle: const TextStyle(color: Colors.redAccent),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(12),
          ),

          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
