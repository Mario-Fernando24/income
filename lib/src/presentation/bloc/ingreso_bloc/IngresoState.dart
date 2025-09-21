import 'package:equatable/equatable.dart';
import 'package:tickets_ingresos/src/domain/models/response/IngresoResponse.dart';
import 'package:tickets_ingresos/src/presentation/utils/blocFormItem.dart';

class IngresoState extends Equatable {
  final BlocFormItem qr;
  final IngresoResponse? ingresoResponse;

  //contructor
  const IngresoState({
    this.qr = const BlocFormItem(error: 'Scanear Boleta', value: null),
    this.ingresoResponse
  });

   IngresoState copyWith({
     BlocFormItem? qr,
     IngresoResponse? ingresoResponse,
  }){
     return IngresoState(
      qr: qr ?? this.qr,
      ingresoResponse: ingresoResponse ?? this.ingresoResponse
     );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [qr,ingresoResponse];
}
