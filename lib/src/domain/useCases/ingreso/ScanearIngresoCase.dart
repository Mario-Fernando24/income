
import 'package:tickets_ingresos/src/domain/repository/IngresoRepository.dart';

class ScanearIngresoUseCase {

   IngresoRepository ingresoRepository;

   ScanearIngresoUseCase(this.ingresoRepository);

   Future<void> run(String qr){
     return ingresoRepository.ingresoEvento(qr);
   }

}