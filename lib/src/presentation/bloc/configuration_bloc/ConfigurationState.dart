import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/presentation/utils/blocFormItem.dart';

enum FormStatus { initial, submitting, success, failure }

class ConfigurationState extends Equatable {
  final BlocFormItem name;
  final BlocFormItem apiName;
  final BlocFormItem logo;
  final BlocFormItem colorPrimary;
  final BlocFormItem colorSecundary;
  final BlocFormItem<bool> beedScanear;
  final FormStatus status;
  final String? errorMessage;
  final GlobalKey<FormState>? formkey;

  const ConfigurationState({
    this.name = const BlocFormItem(error: 'El nombre de la App es obligatorio', value: null),
    this.apiName = const BlocFormItem(error: 'El campo api es obligatorio', value: null),
    this.logo = const BlocFormItem(error: 'El campo logo es obligatorio', value: null),
    this.colorPrimary = const BlocFormItem(error: 'El color primario es obligatorio', value: null),
    this.colorSecundary = const BlocFormItem(error: 'El color secundario es obligatorio', value: null),
    this.beedScanear = const BlocFormItem<bool>(value: false),
    this.status = FormStatus.initial,
    this.errorMessage,
    GlobalKey<FormState>? formkey,
  }) : formkey = formkey ?? const GlobalObjectKey<FormState>('configForm');

  factory ConfigurationState.initial() {
    return const ConfigurationState(
      status: FormStatus.initial,
      errorMessage: null,
    );
  }

  ConfigurationState copyWith({
    BlocFormItem? name,
    BlocFormItem? apiName,
    BlocFormItem? logo,
    BlocFormItem? colorPrimary,
    BlocFormItem? colorSecundary,
    BlocFormItem<bool>? beedScanear,
    FormStatus? status,
    String? errorMessage,
    GlobalKey<FormState>? formkey,
  }) {
    return ConfigurationState(
      name: name ?? this.name,
      apiName: apiName ?? this.apiName,
      logo: logo ?? this.logo,
      colorPrimary: colorPrimary ?? this.colorPrimary,
      colorSecundary: colorSecundary ?? this.colorSecundary,
      beedScanear: beedScanear ?? this.beedScanear,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      formkey: formkey ?? this.formkey,
    );
  }

  @override
  List<Object?> get props => [
        name,
        apiName,
        logo,
        colorPrimary,
        colorSecundary,
        beedScanear,
        status,
        errorMessage,
      ];
}
