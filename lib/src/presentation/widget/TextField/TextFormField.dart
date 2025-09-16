import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String text;
  final Function(String text) onChanged;
  final IconData icon;
  final EdgeInsetsGeometry margin;
  final String? Function(String?)? validate;
  final TextInputType? keyboard;
  final bool obscure;
  final double? size;
  final TextEditingController? controller;
  final String? initialValue;

  const DefaultTextField({
    super.key,
    required this.text,
    required this.onChanged,
    required this.icon,
    this.margin = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.validate,
    this.keyboard,
    this.obscure = false,
    this.size = 14,
    this.controller,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        controller: controller,
        // 👇 Solo usar initialValue si no hay controller
        initialValue: controller == null ? initialValue : null,
        keyboardType: keyboard,
        obscureText: obscure,
        validator: validate,
        style: TextStyle(
          fontSize: size,
          fontFamily: 'MontserratLight',
        ),
        onChanged: (texto) => onChanged(texto),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
          hintText: text,
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
