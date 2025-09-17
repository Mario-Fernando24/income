import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationBloc.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationState.dart';
import 'package:tickets_ingresos/src/presentation/pages/configuration/configurationContent.dart';
import 'package:tickets_ingresos/src/presentation/utils/Resource.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ConfigurationBloc, ConfigurationState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: BlocBuilder<ConfigurationBloc, ConfigurationState>(
          builder: (context, state) {
            return Stack(
              children: [
                ConfigurationContent(state)
              ],
            );
          },
        ),
      ),
    );
  }
}
