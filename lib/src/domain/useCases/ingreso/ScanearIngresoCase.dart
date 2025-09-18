
import 'package:tickets_ingresos/src/domain/repository/IngresoRepository.dart';

class ScanearIngresoUseCase {

   IngresoRepository ingresoRepository;

   ScanearIngresoUseCase(this.ingresoRepository);

   Future<bool> run(String scanear){
     return ingresoRepository.ingreso(scanear);
   }

}