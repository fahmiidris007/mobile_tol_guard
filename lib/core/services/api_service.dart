import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_tol_guard/app/data/models/error_model.dart';
import 'package:mobile_tol_guard/app/domain/entities/constant.dart';
import 'package:mobile_tol_guard/core/exceptions/exceptions.dart';
import 'package:mobile_tol_guard/core/helper/api_helper.dart';
import 'package:mobile_tol_guard/core/services/injection.dart';

@lazySingleton
class ApiService {
  var apiHelper = getIt<ApiHelper>();
  ApiService();

  Future<Response<dynamic>> connect(
    String path,
    Map<String, dynamic> data,
    String method, {
    bool isFormData = false,
    Map<String, dynamic>? extra,
  }) async {
    try {
      Response<dynamic> response;

      var requestPath = path;

      switch (method) {
        case Constant.get:
          response = await apiHelper.get(
            requestPath,
            data,
            extra,
          );
          break;
        default:
          response = await apiHelper.post(
            requestPath,
            isFormData ? FormData.fromMap(data) : data,
            extra,
          );
      }

      return response;
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw ServerException(
        ErrorModel(message: e.error.toString()),
        requestOptions: e.requestOptions,
        dioError: e,
      );
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
