import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_tol_guard/app/data/models/auth/login_model.dart';
import 'package:mobile_tol_guard/app/data/models/error_model.dart';
import 'package:mobile_tol_guard/app/domain/repositories/auth_repository.dart';
import 'package:mobile_tol_guard/core/use_cases/use_case.dart';

@lazySingleton
class Login implements UseCase<LoginModel, LoginParams> {
  final AuthRepository repository;

  Login(this.repository);

  @override
  Future<Either<ErrorModel, LoginModel>> call(LoginParams params) async {
    return await repository.login(params);
  }
}
