import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_ingresos/blocProviders.dart';
import 'package:tickets_ingresos/injection.dart';
import 'package:tickets_ingresos/src/config/app_routes.dart';
import 'package:tickets_ingresos/src/data/datasource/local/SharefPref.dart';
import 'package:tickets_ingresos/src/presentation/utils/const/PreferenceKeys.dart';

final prefs = SharefPref();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  final jsonString = await prefs.read(PreferenceKeys.appConfiguration);
  Color seedColor = Colors.cyan;

  if (jsonString != null && jsonString.isNotEmpty) {
    try {
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      final primaryHex = jsonData["colorPrimary"] as String?;
      if (primaryHex != null && primaryHex.isNotEmpty) {
        seedColor = _hexToColor(primaryHex);
      }
    } catch (e) {
      debugPrint("Error leyendo preferencias: $e");
    }
  }

  runApp(MyApp(seedColor: seedColor));
}

Color _hexToColor(String hex) {
  hex = hex.replaceAll("#", "");
  if (hex.length == 6) {
    hex = "FF$hex"; 
  }
  return Color(int.parse(hex, radix: 16));
}

class MyApp extends StatelessWidget {
  final Color seedColor;

  const MyApp({super.key, required this.seedColor});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TICKETS INGRESOS',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        ),
        initialRoute: AppRoutes.welcome,
        routes: AppRoutes.routes,
      ),
    );
  }
}
