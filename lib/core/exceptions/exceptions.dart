import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:mobile_tol_guard/app/data/models/error_model.dart';

class ServerException extends DioException {
  ErrorModel responseError;
  DioException? dioError;

  ServerException(
    this.responseError, {
    this.dioError,
    required super.requestOptions,
  }) : super();
}

/// TODO : If Firebase Crashlytics already, impements this
// extension CrashlyticsReporter on Object {
//   void reportToCrashlytics([StackTrace? stack]) async {
//     FirebaseCrashlytics.instance
//         .setUserIdentifier((await Utility.getCustomerId).toString());
//     FirebaseCrashlytics.instance
//         .setCustomKey("Device ID", (await Utility.getDeviceId).toString());

//     FirebaseCrashlytics.instance.recordError(
//       this,
//       stack ?? StackTrace.current,
//       information: [],
//       printDetails: true,
//     );
//     debugPrint(
//         ' ==========\n send to Crashlytics: $this \n $stack \n==========');
//   }
// }
