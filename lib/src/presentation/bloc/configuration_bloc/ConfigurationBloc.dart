import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationEvent.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationState.dart';
import 'package:tickets_ingresos/src/presentation/utils/blocFormItem.dart';
import 'package:tickets_ingresos/src/presentation/utils/validators/url_validator.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  
  final formKey = GlobalKey<FormState>();

  ConfigurationBloc() : super(ConfigurationState()) {
    on<ConfigurationInitEvent>((event, emit) {
      emit(state.copyWith(formkey: formKey));
    });

    on<NameChanged>((event, emit) {
      emit(
        state.copyWith(
          name: BlocFormItem(
            value: event.name.value,
            error: event.name.value.isEmpty ? 'El nombre de la App es obligatorio' : event.name.value.length<=2? 'Deber ser mayor a 3 caracteres' :null,
          ),
          formkey: formKey,
        ),
      );
    });

      on<ApiNameChanged>((event, emit) {
      final value = event.apiName.value.trim();
      final error = UrlValidator.validateApiUrl(value); // Usamos el validador

      emit(
        state.copyWith(
          apiName: BlocFormItem(
            value: value,
            error: error, // Ahora el error viene del validador centralizado
          ),
          formkey: formKey,
        ),
      );
    });

    on<BeedScanearChanged>((event, emit) {
        emit(
          state.copyWith(
            beedScanear: BlocFormItem(
              value: event.beedScanear.value,
              error: null,
            ),
            formkey: formKey,
          ),
        );
      });

      on<LogoChanged>((event, emit) {
      emit(
        state.copyWith(
          logo: BlocFormItem(
            value: event.logo.value,
            error: event.logo.value.isEmpty ? 'El campo logo es obligatorio' : null,
          ),
          formkey: formKey,
        ),
      );
    });

    on<ColorPrimaryChanged>((event, emit) {
      emit(
        state.copyWith(
          logo: BlocFormItem(
            value: event.colorPrimary.value,
            error: event.colorPrimary.value.isEmpty ? 'El campo logo es obligatorio' : null,
          ),
          formkey: formKey,
        ),
      );
    });

       on<ColorSecundaryChanged>((event, emit) {
      emit(
        state.copyWith(
          logo: BlocFormItem(
            value: event.colorSecundary.value,
            error: event.colorSecundary.value.isEmpty ? 'El campo logo es obligatorio' : null,
          ),
          formkey: formKey,
        ),
      );
    });


    on<FormSubmit>((event, emit) async {
      print("*********************************************************************");
       print(state.name.value);
       print(state.apiName.value);
       print(state.logo.value);
       print(state.beedScanear.value);
       print("*********************************************************************");
    });
  }
}
