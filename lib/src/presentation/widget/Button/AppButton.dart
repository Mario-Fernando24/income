import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/config/app_theme.dart';

enum AppButtonType { primary, secondary, danger }


// AppButton(
//   label: "Guardar",
//   icon: Icons.save,
//   type: AppButtonType.primary,
//   onPressed: () => print("Guardado"),
// ),

// AppButton(
//   label: "Cancelar",
//   icon: Icons.cancel,
//   type: AppButtonType.danger,
//   onPressed: () => print("Cancelado"),
// ),

// AppButton(
//   label: "Editar",
//   icon: Icons.edit,
//   type: AppButtonType.secondary,
//   onPressed: () => print("Editar"),
// ),/
class AppButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final AppButtonType type;

  const AppButton({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.type = AppButtonType.primary,
  });

  Color _getBackgroundColor() {
    switch (type) {
      case AppButtonType.secondary:
        return AppColors.secondary;
      case AppButtonType.danger:
        return AppColors.error;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: FilledButton.styleFrom(
        backgroundColor: _getBackgroundColor(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
