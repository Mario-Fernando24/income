
import 'package:tickets_ingresos/src/presentation/utils/blocFormItem.dart';

abstract class IngresoEvent {}

class IngresoInitEvent extends IngresoEvent{}

class IngresoSubmit extends IngresoEvent{

  final String qr;
  IngresoSubmit({required this.qr});
}

