import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_ingresos/src/domain/useCases/ingreso/IngresoCases.dart';
import 'package:tickets_ingresos/src/presentation/bloc/ingreso_bloc/IngresoEvent.dart';
import 'package:tickets_ingresos/src/presentation/bloc/ingreso_bloc/IngresoState.dart';

class IngresoBloc extends Bloc<IngresoEvent, IngresoState> {
  
  Ingresousecases ingresousecases;

  IngresoBloc(this.ingresousecases) : super(IngresoState()) {
   
  
    on<IngresoInitEvent>((event, emit) async {
      // Aquí defines el estado inicial o lo que quieras hacer
      emit(state.copyWith(
        // inicializa valores si hace falta
      ));
    });
    
    on<IngresoSubmit>((event, emit) async {

      print("sumbaaa mariooooooooooooo fernando");
      print("======> "+event.qr);
      print("sumba mariooooooooo");


      await ingresousecases.scanearIngresoUseCase.run(event.qr);

    });
  }
}
