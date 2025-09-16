import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextField extends StatelessWidget {
  final String text; // etiqueta/placeholder
  final ValueChanged<String> onChanged;
  final IconData icon;

  // Opcionales
  final EdgeInsetsGeometry margin;
  final String? Function(String?)? validate;
  final TextInputType? keyboard;
  final bool obscure;
  final double? size;
  final TextEditingController? controller;
  final String? initialValue;

  // ✅ Nuevos (para mantener foco y mejorar UX)
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final bool enableSuggestions;
  final bool autocorrect;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines; // null permite multiline si quieres
  final int? minLines;
  final Widget? suffixIcon;

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

    // nuevos con defaults sensatos
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
    this.enabled = true,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: margin,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,

        // 🔒 Solo usar initialValue si NO hay controller
        initialValue: controller == null ? initialValue : null,

        keyboardType: keyboard,
        obscureText: obscure,
        validator: validate,
        enabled: enabled,
        textInputAction: textInputAction,
        onFieldSubmitted: onSubmitted,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enableSuggestions: enableSuggestions,
        autocorrect: autocorrect,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        maxLines: obscure ? 1 : maxLines, // si es password, fuerza 1 línea
        minLines: minLines,

        style: TextStyle(
          fontSize: size,
          fontFamily: 'MontserratLight',
        ),

        onChanged: onChanged,

        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: theme.colorScheme.primary),
          // Puedes usar ambas si quieres label flotante + hint
          labelText: text,
          hintText: text,

          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          fillColor: theme.colorScheme.surfaceVariant,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 20),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
          errorMaxLines: 2,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
