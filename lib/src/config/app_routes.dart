import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/presentation/pages/configuration/configurationPage.dart';
import 'package:tickets_ingresos/src/presentation/pages/ingresos/ingresoContent.dart';
import 'package:tickets_ingresos/src/presentation/pages/welcome/welcome.dart';

class AppRoutes {
  static const String welcome = 'welcome';
  static const String configurations = 'configurations';
  static const String ingreso = 'ingreso';

  static Map<String, WidgetBuilder> get routes {
    return {
      welcome: (BuildContext context) => WelcomePage(),
      configurations: (BuildContext context) => ConfigurationPage(),
      ingreso: (BuildContext context) => IngresoPage(),
    };
  }
}
