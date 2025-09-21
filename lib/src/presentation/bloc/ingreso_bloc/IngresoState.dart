import 'package:equatable/equatable.dart';
import 'package:tickets_ingresos/src/presentation/utils/blocFormItem.dart';

class IngresoState extends Equatable {
  final BlocFormItem qr;

  //contructor
  const IngresoState({
    this.qr = const BlocFormItem(error: 'Scanear Boleta', value: null),
  });

  IngresoState copyWith({BlocFormItem? qr}) {
    return IngresoState(qr: qr ?? this.qr);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [qr];
}
