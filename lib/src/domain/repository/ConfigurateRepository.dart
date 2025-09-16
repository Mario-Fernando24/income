
import 'package:tickets_ingresos/src/domain/models/request/configurate_request.dart';

abstract class Configuraterepository {

  Future<bool> saveConfigurate(ConfigurateRequest configurate);

  Future<ConfigurateRequest?> getConfigurate();

}