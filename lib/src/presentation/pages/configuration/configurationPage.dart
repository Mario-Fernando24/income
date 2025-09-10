import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/presentation/pages/configuration/configurationContent.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  @override
  Widget build(BuildContext context) {
    return ConfigurationContent();
  }
}