
import 'package:tickets_ingresos/src/presentation/utils/blocFormItem.dart';

abstract class ConfigurationEvent {}

class ConfigurationInitEvent extends ConfigurationEvent{}

class NameChanged extends ConfigurationEvent{

  final BlocFormItem name;
  NameChanged({required this.name});
}

class ApiNameChanged extends ConfigurationEvent{

  final BlocFormItem apiName;
  ApiNameChanged({required this.apiName});
}

class BeepScanChanged extends ConfigurationEvent{

  final BlocFormItem beeps;
  BeepScanChanged({required this.beeps});
}

class LogoChanged extends ConfigurationEvent{

  final BlocFormItem logo;
  LogoChanged({required this.logo});
}

class FormSubmit extends ConfigurationEvent{}
