
import 'package:tickets_ingresos/src/domain/models/response/IngresoResponse.dart';
import 'package:tickets_ingresos/src/domain/repository/IngresoRepository.dart';

class ScanearIngresoUseCase {

   IngresoRepository ingresoRepository;

   ScanearIngresoUseCase(this.ingresoRepository);

   Future<IngresoResponse> run(String qr){
     return ingresoRepository.ingresoEvento(qr);
   }

}