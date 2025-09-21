import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/presentation/pages/ingresos/ingresoContent.dart';

class IngresoPage extends StatelessWidget {
  const IngresoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final String primary = args?["primary"] ?? "#195E3D";
    final String secondary = args?["secondary"] ?? "#FAFFFD";

    return Scaffold(
      body: Stack(children: [IngresoContent(primary, secondary)]),
    );
  }
}
