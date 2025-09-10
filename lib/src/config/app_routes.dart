import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/presentation/pages/configuration/configurationPage.dart';

class AppRoutes {
  static const String configurations = 'configurations';

  static Map<String, WidgetBuilder> get routes {
    return {
      configurations: (BuildContext context) => ConfigurationPage(),
    };
  }
}
