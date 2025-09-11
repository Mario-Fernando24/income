import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/presentation/utils/blocFormItem.dart';

class ConfigurationState extends Equatable {

  final BlocFormItem name;
  final BlocFormItem apiName;
  final BlocFormItem logo;

   //controlar el formulario
  final GlobalKey<FormState>? formkey;

  //contructor
  const ConfigurationState({
    this.name = const BlocFormItem(error: 'El nombre de la App es obligatorio'),
    this.apiName = const BlocFormItem(error: 'EL campo api es obligatorio'),
    this.logo = const BlocFormItem(error: 'El campo logo es obligatorio'),
    GlobalKey<FormState>? formkey,
  }) : formkey = formkey ?? const GlobalObjectKey<FormState>('configForm');

  ConfigurationState copyWith({
     BlocFormItem? name,
     BlocFormItem? apiName,
     BlocFormItem? logo,
     GlobalKey<FormState>? formkey,
  }){
     return ConfigurationState(
      name: name ?? this.name,
      apiName: apiName ?? this.apiName,
      logo: logo ?? this.logo,
      formkey: formkey,
     );
  }

  //las variables que van a cambiar de estados
  @override
  // TODO: implement props
  List<Object?> get props => [name, apiName, logo];

}