import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_ingresos/blocProviders.dart';
import 'package:tickets_ingresos/injection.dart';
import 'package:tickets_ingresos/src/config/app_routes.dart';
import 'package:tickets_ingresos/src/data/datasource/local/SharefPref.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await configureDependencies();
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TICKETS INGRESOS',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        ),
        initialRoute: AppRoutes.welcome,
        routes: AppRoutes.routes,
      ),
    );
  }
}
