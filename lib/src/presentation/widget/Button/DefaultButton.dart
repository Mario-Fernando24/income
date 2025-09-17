import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String label;
  final String backgroundHex; // Color de fondo en hexadecimal
  final String textHex;       // Color del texto en hexadecimal
  final IconData? icon;
  final VoidCallback onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final FontWeight fontWeight;

  const DefaultButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundHex = "FF2196F3", // Azul por defecto
    this.textHex = "FFFFFFFF",       // Blanco por defecto
    this.icon,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
  });

  // Función para convertir hexadecimal a Color
  Color _hexToColor(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) hex = "FF$hex"; // agregar opacidad si falta
    return Color(int.parse(hex, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _hexToColor(backgroundHex);
    final txtColor = _hexToColor(textHex);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon, color: txtColor) : const SizedBox.shrink(),
        label: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: 'MontserratBold',
            color: txtColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
