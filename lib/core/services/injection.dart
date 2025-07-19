import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_tol_guard/core/services/injection.config.dart';

GetIt getIt = GetIt.instance;

@InjectableInit(asExtension: false)
GetIt configureDependencies() => init(getIt);
