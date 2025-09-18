// agregar todos los use cases de auth
import 'package:tickets_ingresos/src/domain/useCases/ingreso/ScanearIngresoCase.dart';

class Ingresousecases {
   
  final ScanearIngresoUseCase scanearIngresoUseCase;

   Ingresousecases({
    required this.scanearIngresoUseCase,
   });

}