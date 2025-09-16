// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:tickets_ingresos/src/data/datasource/local/configurateService.dart'
    as _i595;
import 'package:tickets_ingresos/src/di/AppModule.dart' as _i474;
import 'package:tickets_ingresos/src/domain/repository/ConfigurateRepository.dart'
    as _i335;
import 'package:tickets_ingresos/src/domain/useCases/configurate/ConfigurateCases.dart'
    as _i136;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i595.Configurateservices>(() => appModule.conf);
    gh.factory<_i335.Configuraterepository>(() => appModule.authrepository);
    gh.factory<_i136.Configurateusecases>(() => appModule.configurate);
    return this;
  }
}

class _$AppModule extends _i474.AppModule {}
