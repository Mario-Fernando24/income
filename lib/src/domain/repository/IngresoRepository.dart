import 'package:tickets_ingresos/src/domain/models/response/IngresoResponse.dart';

abstract class IngresoRepository {

  Future<IngresoResponse> ingresoEvento(String scanear);


}