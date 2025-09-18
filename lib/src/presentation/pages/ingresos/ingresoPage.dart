import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/presentation/pages/ingresos/ingresoContent.dart';

class IngresoPage extends StatelessWidget {
  const IngresoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IngresoContent()
          ]
      )
    );
  }
}
