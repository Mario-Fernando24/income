import 'package:tickets_ingresos/src/domain/models/request/configurate_request.dart';
import 'package:tickets_ingresos/src/domain/repository/ConfigurateRepository.dart';

class GetConfiguracionUseCase {
  final Configuraterepository configuraterepository;

  GetConfiguracionUseCase(this.configuraterepository);

  Future<ConfigurateRequest?> run() {
    return configuraterepository.getConfigurate();
  }
}
