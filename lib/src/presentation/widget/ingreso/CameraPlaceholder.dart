import 'package:flutter/material.dart';

class CameraPlaceholder extends StatelessWidget {
  const CameraPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F172A), Color(0xFF111827)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        const Center(
          child: Icon(Icons.qr_code_scanner_rounded, size: 120, color: Colors.white24),
        ),
      ],
    );
  }
}
