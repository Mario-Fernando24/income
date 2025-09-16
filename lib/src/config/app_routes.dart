import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/presentation/pages/configuration/configurationPage.dart';
import 'package:tickets_ingresos/src/presentation/pages/welcome/welcome.dart';

class AppRoutes {
  static const String configurations = 'configurations';
  static const String welcome = 'welcome';

  static Map<String, WidgetBuilder> get routes {
    return {
      configurations: (BuildContext context) => ConfigurationPage(),
      welcome: (BuildContext context) => WelcomePage(),
    };
  }
}
