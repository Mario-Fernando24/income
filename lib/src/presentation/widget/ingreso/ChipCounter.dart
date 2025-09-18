import 'package:flutter/material.dart';

class ChipCounter extends StatelessWidget {
  final IconData icon;
  final int value;
  final Color color;

  const ChipCounter({
    required this.icon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color.withOpacity(0.12),
      label: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(' $value', style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      side: BorderSide(color: color.withOpacity(0.2)),
    );
  }
}
