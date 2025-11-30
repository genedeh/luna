import 'package:flutter/material.dart';
import 'package:luna/widgets/form_widgets/custom_input_field_widget.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;
  const UsernameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomInputFieldWidget(
      label: "Username",
      controller: controller,
      helper: "3–16 characters. No spaces.",
      validator: (value) {
        if (value == null || value.isEmpty) return "Username is required";
        if (value.length < 3) return "Must be at least 3 characters";
        if (value.contains(" ")) return "No spaces allowed";
        return null;
      },
    );
  }
}
