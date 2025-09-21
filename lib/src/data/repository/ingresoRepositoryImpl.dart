import 'package:tickets_ingresos/src/data/datasource/remote/ingresoService.dart';
import 'package:tickets_ingresos/src/domain/repository/IngresoRepository.dart';

class Ingresorepositoryimp implements IngresoRepository {
  IngresoServices ingresoServices;

  Ingresorepositoryimp(this.ingresoServices);

  @override
  Future<void> ingresoEvento(String qr) {
    return ingresoServices.ingresoEvento(qr);
  }

}
