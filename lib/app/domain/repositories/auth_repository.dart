import 'package:dartz/dartz.dart';
import 'package:mobile_tol_guard/app/data/models/auth/login_model.dart';
import 'package:mobile_tol_guard/app/data/models/error_model.dart';

abstract class AuthRepository {
  Future<Either<ErrorModel, LoginModel>> login(LoginParams params);
}
