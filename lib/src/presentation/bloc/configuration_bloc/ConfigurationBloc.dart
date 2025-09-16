import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_ingresos/src/config/app_theme.dart';
import 'package:tickets_ingresos/src/domain/models/request/configurate_request.dart';
import 'package:tickets_ingresos/src/domain/useCases/configurate/ConfigurateCases.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationEvent.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationState.dart';
import 'package:tickets_ingresos/src/presentation/utils/blocFormItem.dart';
import 'package:tickets_ingresos/src/presentation/utils/validators/url_validator.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {

  Configurateusecases configurateusecases;
  final formKey = GlobalKey<FormState>();

  ConfigurationBloc(this.configurateusecases) : super(ConfigurationState.initial()) {
    
    on<ConfigurationInitEvent>((event, emit) {
      emit(state.copyWith(formkey: formKey));
    });

    on<LoadConfiguration>((event, emit) async {
      emit(state.copyWith(status: FormStatus.submitting));

      try {
        final conf = await configurateusecases.getConfiguracionUseCase.run();

        if (conf != null) {
          emit(state.copyWith(
            status: FormStatus.initial,
            name: BlocFormItem(value: conf.name),
            apiName: BlocFormItem(value: conf.apiName),
            logo: BlocFormItem(value: conf.logo),
            beedScanear: BlocFormItem(value: conf.needScan),
            colorPrimary: BlocFormItem(value: conf.colorPrimary),
            colorSecundary: BlocFormItem(value: conf.colorSecondary),
          ));
        } else {
          emit(state.copyWith(status: FormStatus.initial));
        }
      } catch (e) {
        emit(state.copyWith(
          status: FormStatus.failure,
          errorMessage: e.toString(),
        ));
      }
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
        print("newwwwwwwwwwwwwwwwwwwwwww");
      print(event.beedScanear.value);
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

      print("llegoooooooooooooooooooooooooooooo");
      print(event.colorPrimary.value);
      emit(
        state.copyWith(
          colorPrimary: BlocFormItem(
            value: event.colorPrimary.value,
            error: "",
          ),
          formkey: formKey,
        ),
      );
    });

    on<ColorSecundaryChanged>((event, emit) {

      print("secundariooooooooooooo");
      print(event.colorSecundary.value);
      emit(
        state.copyWith(
          colorSecundary: BlocFormItem(
            value: event.colorSecundary.value,
            error: "",
          ),
          formkey: formKey,
        ),
      );
    });


      on<FormSubmit>((event, emit) async {
      emit(state.copyWith(status: FormStatus.submitting));

  await Future.delayed(const Duration(milliseconds: 900));

      final confRequest = ConfigurateRequest(
        name: state.name.value,
        apiName: state.apiName.value,
        logo: state.logo.value,
        needScan: state.beedScanear.value,
        colorPrimary: state.colorPrimary.value ??
            '#${AppColors.primary.value.toRadixString(16).padLeft(8, '0').substring(2)}',
        colorSecondary: state.colorSecundary.value ??
            '#${AppColors.secondary.value.toRadixString(16).padLeft(8, '0').substring(2)}',
      );

      try {
        bool resp = await configurateusecases.configuracionUseCase.run(confRequest);
        print("inicioooooo. 2222");

        if (resp) {
          emit(state.copyWith(status: FormStatus.success));


         print("inicioooooo. 33333 MAR $resp");

        } else {
          emit(state.copyWith(status: FormStatus.failure, errorMessage: "Error al guardar la configuración"));
        }
      } catch (e) {
        emit(state.copyWith(status: FormStatus.failure, errorMessage: e.toString()));
      }
    });

  }
}
