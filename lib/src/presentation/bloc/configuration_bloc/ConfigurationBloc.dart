import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationEvent.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationState.dart';
import 'package:tickets_ingresos/src/presentation/utils/blocFormItem.dart';

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
      emit(
        state.copyWith(
          apiName: BlocFormItem(
            value: event.apiName.value,
            error: event.apiName.value.isEmpty ? 'EL campo api es obligatorio' : null,
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


    on<FormSubmit>((event, emit) async {
       print(state.name.value);
       print(state.apiName.value);
       print(state.logo.value);
    });
  }
}
