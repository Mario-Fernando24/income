// agregar todos los use cases de auth

import 'package:tickets_ingresos/src/domain/useCases/configurate/ConfiguracionUseCase.dart';
import 'package:tickets_ingresos/src/domain/useCases/configurate/GetConfiguracionUseCase.dart';

class Configurateusecases {
   
  final ConfiguracionUseCase configuracionUseCase;
  final GetConfiguracionUseCase getConfiguracionUseCase;

   Configurateusecases({
    required this.configuracionUseCase,
    required this.getConfiguracionUseCase,

   });

}