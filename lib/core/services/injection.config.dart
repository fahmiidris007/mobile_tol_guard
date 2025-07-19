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
import 'package:mobile_tol_guard/app/data/data_sources/auth_data_source.dart'
    as _i713;
import 'package:mobile_tol_guard/app/data/repositories/auth_repository_impl.dart'
    as _i366;
import 'package:mobile_tol_guard/app/domain/entities/global.dart' as _i605;
import 'package:mobile_tol_guard/app/domain/repositories/auth_repository.dart'
    as _i39;
import 'package:mobile_tol_guard/app/domain/use_cases/auth/login.dart' as _i83;
import 'package:mobile_tol_guard/core/helper/api_helper.dart' as _i905;
import 'package:mobile_tol_guard/core/services/api_service.dart' as _i40;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i905.ApiHelper>(() => _i905.ApiHelper());
  gh.lazySingleton<_i40.ApiService>(() => _i40.ApiService());
  gh.lazySingleton<_i605.Global>(() => _i605.Global());
  gh.lazySingleton<_i713.AuthDataSource>(() => _i713.AuthDataSourceImpl());
  gh.lazySingleton<_i39.AuthRepository>(() => _i366.AuthRepositoryImpl());
  gh.lazySingleton<_i83.Login>(() => _i83.Login(gh<_i39.AuthRepository>()));
  return getIt;
}
