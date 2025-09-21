import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_ingresos/src/domain/models/request/configurate_request.dart';
import 'package:tickets_ingresos/src/domain/useCases/ingreso/IngresoCases.dart';
import 'package:tickets_ingresos/src/presentation/bloc/ingreso_bloc/IngresoEvent.dart';
import 'package:tickets_ingresos/src/presentation/bloc/ingreso_bloc/IngresoState.dart';
import 'package:tickets_ingresos/src/presentation/utils/functions/getData.dart';

class IngresoBloc extends Bloc<IngresoEvent, IngresoState> {
  Ingresousecases ingresousecases;
  final dataApp = DataApp();

  IngresoBloc(this.ingresousecases) : super(IngresoState()) {
    on<IngresoInitEvent>((event, emit) async {
      // Aquí defines el estado inicial o lo que quieras hacer
      emit(
        state.copyWith(
          // inicializa valores si hace falta
        ),
      );
    });

    on<IngresoSubmit>((event, emit) async {
    
      final respon = await ingresousecases.scanearIngresoUseCase.run(event.qr);

      ConfigurateRequest? config = await dataApp.getConfiguratePreference();

      if (config!.needScan) {
        if (respon.success) {
          _playSound("assets_sonid_sonido.mp3");
        } else if (!respon.success) {
          _playSound("error_beep.mp3");
        }
      }
      emit(state.copyWith(ingresoResponse: respon));
    });
  }

  void _playSound(String beep) async {
    final player = AudioPlayer();
    await player.play(AssetSource("sonid/${beep}"));
  }
}
