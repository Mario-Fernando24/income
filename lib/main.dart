import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/config/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TICKETS INGRESOS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      initialRoute: AppRoutes.configurations,
      routes: AppRoutes.routes,
    );
  }
}
