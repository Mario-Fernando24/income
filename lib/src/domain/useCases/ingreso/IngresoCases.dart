// agregar todos los use cases de auth

import 'package:tickets_ingresos/src/domain/useCases/configurate/ConfiguracionUseCase.dart';
import 'package:tickets_ingresos/src/domain/useCases/configurate/GetConfiguracionUseCase.dart';

class Ingresousecases {
   
  final ConfiguracionUseCase configuracionUseCase;

   Ingresousecases({
    required this.configuracionUseCase,
   });

}