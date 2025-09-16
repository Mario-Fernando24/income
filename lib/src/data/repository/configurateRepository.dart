import 'package:tickets_ingresos/src/data/datasource/local/configurateService.dart';
import 'package:tickets_ingresos/src/domain/models/request/configurate_request.dart';
import 'package:tickets_ingresos/src/domain/repository/ConfigurateRepository.dart';

class Configuraterepositoryimp implements  Configuraterepository {
   
      
  Configurateservices configurateservices;

  Configuraterepositoryimp(this.configurateservices);

  @override
  Future<bool> saveConfigurate(ConfigurateRequest configurate) {
      return configurateservices.saveConfigurate(configurate);
  }
  
  @override
  Future<ConfigurateRequest?> getConfigurate() {
    return configurateservices.getConfigurate();
  }
   
  
}