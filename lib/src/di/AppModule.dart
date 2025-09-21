import 'package:injectable/injectable.dart';
import 'package:tickets_ingresos/src/data/datasource/local/configurateService.dart';
import 'package:tickets_ingresos/src/data/datasource/remote/ingresoService.dart';
import 'package:tickets_ingresos/src/data/repository/configurateRepository.dart';
import 'package:tickets_ingresos/src/data/repository/ingresoRepositoryImpl.dart';
import 'package:tickets_ingresos/src/domain/repository/ConfigurateRepository.dart';
import 'package:tickets_ingresos/src/domain/repository/IngresoRepository.dart';
import 'package:tickets_ingresos/src/domain/useCases/configurate/ConfiguracionUseCase.dart';
import 'package:tickets_ingresos/src/domain/useCases/configurate/ConfigurateCases.dart';
import 'package:tickets_ingresos/src/domain/useCases/configurate/GetConfiguracionUseCase.dart';
import 'package:tickets_ingresos/src/domain/useCases/ingreso/IngresoCases.dart';
import 'package:tickets_ingresos/src/domain/useCases/ingreso/ScanearIngresoCase.dart';
//flutter pub run build_runner build --delete-conflicting-outputs

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

  // Ingreso (remoto)
  @injectable
  IngresoServices get ingresoServices => IngresoServices();

  @injectable
  IngresoRepository get ingresoRepository => Ingresorepositoryimp(ingresoServices);

  @injectable
  ScanearIngresoUseCase get scanearIngresoUseCase => ScanearIngresoUseCase(ingresoRepository);

  @injectable
  Ingresousecases get ingresoUseCases => Ingresousecases(
    scanearIngresoUseCase: scanearIngresoUseCase);

}