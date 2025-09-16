
import 'package:tickets_ingresos/src/domain/models/request/configurate_request.dart';

abstract class Configuraterepository {

  Future<dynamic> saveConfigurate(ConfigurateRequest configurate);

}