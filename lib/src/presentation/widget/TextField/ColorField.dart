import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/presentation/utils/olor_parser.dart';

class ColorField extends StatelessWidget {
  final String label;
  final String initial;
  const ColorField({required this.label, required this.initial});
  @override
  Widget build(BuildContext context) {
    final color = parseHex(initial);
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: initial,
            decoration: InputDecoration(
              labelText: label,
              hintText: '#0ea5e9',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12),
          ),
        ),
      ],
    );
  }
}
