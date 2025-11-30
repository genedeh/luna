import 'package:flutter/material.dart';
import 'package:luna/widgets/form_widgets/custom_input_field_widget.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomInputFieldWidget(
      label: "Email",
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) return "Email is required";

        final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$");
        if (!emailRegex.hasMatch(value)) return "Invalid email";

        return null;
      },
    );
  }
}
