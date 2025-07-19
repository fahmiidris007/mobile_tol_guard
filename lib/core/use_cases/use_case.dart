import 'package:dartz/dartz.dart';
import 'package:mobile_tol_guard/app/data/models/error_model.dart';

abstract class UseCase<Type, Params> {
  Future<Either<ErrorModel, Type>> call(Params params);
}
