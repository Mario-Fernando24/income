import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationBloc.dart';

List<BlocProvider> blocProviders = [
   
   BlocProvider<ConfigurationBloc>(create: (context) => ConfigurationBloc()),

];