import 'package:tickets_ingresos/src/domain/models/request/configurate_request.dart';
import 'package:tickets_ingresos/src/domain/repository/ConfigurateRepository.dart';

class ConfiguracionUseCase {

   Configuraterepository configuraterepository;

   ConfiguracionUseCase(this.configuraterepository);

   Future<bool> run(ConfigurateRequest config){
     return configuraterepository.saveConfigurate(config);
   }

}