import 'package:injectable/injectable.dart';
import 'package:tickets_ingresos/src/data/datasource/local/configurateService.dart';
import 'package:tickets_ingresos/src/data/repository/configurateRepository.dart';
import 'package:tickets_ingresos/src/domain/repository/ConfigurateRepository.dart';
import 'package:tickets_ingresos/src/domain/useCases/configurate/ConfiguracionUseCase.dart';
import 'package:tickets_ingresos/src/domain/useCases/configurate/ConfigurateCases.dart';
import 'package:tickets_ingresos/src/domain/useCases/configurate/GetConfiguracionUseCase.dart';

@module
abstract class AppModule {
   
   @injectable 
  Configurateservices get conf => Configurateservices();

  @injectable
  Configuraterepository get authrepository => Configuraterepositoryimp(conf);

  @injectable
  Configurateusecases get configurate => Configurateusecases(
    configuracionUseCase: ConfiguracionUseCase(authrepository),
    getConfiguracionUseCase: GetConfiguracionUseCase(authrepository),
    );



}