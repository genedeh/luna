import 'package:flutter/material.dart';
import 'package:luna/widgets/form_widgets/custom_input_field_widget.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return CustomInputFieldWidget(
      label: "Password",
      controller: widget.controller,
      obscure: !_visible, 
      helper: "At least 8 characters",
      validator: (value) {
        if (value == null || value.isEmpty) return "Password is required";
        if (value.length < 8) return "Password must be at least 8 characters";
        return null;
      },

      /// 👇 This is the toggle icon
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            _visible = !_visible;
          });
        },
        child: Icon(_visible ? Icons.visibility : Icons.visibility_off),
      ),
    );
  }
}
