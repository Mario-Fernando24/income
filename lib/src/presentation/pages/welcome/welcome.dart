import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/config/app_routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
             Navigator.pushNamed(context, AppRoutes.configurations);
            },
            child: Text("INICIAR"))
        ],
      ),
    );
  }
}