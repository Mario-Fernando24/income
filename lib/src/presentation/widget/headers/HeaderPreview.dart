import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/presentation/utils/olor_parser.dart';

class HeaderPreview extends StatelessWidget {
  final String name;
  final String primaryHex;
  final String accentHex;
  const HeaderPreview({
    required this.name,
    required this.primaryHex,
    required this.accentHex,
  });
  @override
  Widget build(BuildContext context) {
    final primary = parseHex(primaryHex);
    final accent = parseHex(accentHex);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(colors: [primary, accent]),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 24,
            child: const Icon(Icons.confirmation_number, color: Colors.black87),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}