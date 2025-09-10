import 'package:flutter/material.dart';

class ModernField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final TextInputType? keyboard;
  final IconData? icon;
  final bool obscure;

  const ModernField({
    super.key,
    required this.controller,
    this.hint,
    this.keyboard,
    this.icon,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        obscureText: obscure,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          prefixIcon: icon != null
              ? Icon(icon, color: Theme.of(context).colorScheme.primary)
              : null,
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceVariant,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
