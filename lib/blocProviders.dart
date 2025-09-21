import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_ingresos/injection.dart';
import 'package:tickets_ingresos/src/domain/useCases/configurate/ConfigurateCases.dart';
import 'package:tickets_ingresos/src/domain/useCases/ingreso/IngresoCases.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationBloc.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationEvent.dart';
import 'package:tickets_ingresos/src/presentation/bloc/ingreso_bloc/IngresoBloc.dart';
import 'package:tickets_ingresos/src/presentation/bloc/ingreso_bloc/IngresoEvent.dart';

List<BlocProvider> blocProviders = [
   
   BlocProvider<ConfigurationBloc>(create: (context) => ConfigurationBloc(locator<Configurateusecases>())..add(ConfigurationInitEvent())),
   BlocProvider<IngresoBloc>(create: (context) => IngresoBloc(locator<Ingresousecases>())..add(IngresoInitEvent())),


];