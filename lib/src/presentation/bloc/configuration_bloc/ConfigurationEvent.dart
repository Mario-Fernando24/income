import 'package:tickets_ingresos/src/presentation/utils/blocFormItem.dart';

abstract class ConfigurationEvent {}

class ConfigurationInitEvent extends ConfigurationEvent {}

class NameChanged extends ConfigurationEvent {
  final BlocFormItem name;
  NameChanged({required this.name});
}

class ApiNameChanged extends ConfigurationEvent {
  final BlocFormItem apiName;
  ApiNameChanged({required this.apiName});
}

class BeedScanearChanged extends ConfigurationEvent {
  final BlocFormItem<bool> beedScanear;
  BeedScanearChanged({required this.beedScanear});
}

class LogoChanged extends ConfigurationEvent {
  final BlocFormItem logo;
  LogoChanged({required this.logo});
}

class ColorPrimaryChanged extends ConfigurationEvent {
  final BlocFormItem colorPrimary;
  ColorPrimaryChanged({required this.colorPrimary});
}

class ColorSecundaryChanged extends ConfigurationEvent {
  final BlocFormItem colorSecundary;
  ColorSecundaryChanged({required this.colorSecundary});
}

class LoadConfiguration extends ConfigurationEvent {}
class ResetStatus extends ConfigurationEvent {}

class FormSubmit extends ConfigurationEvent {}