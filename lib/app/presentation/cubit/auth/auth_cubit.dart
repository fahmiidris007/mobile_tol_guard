import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_tol_guard/app/data/models/auth/login_model.dart';
import 'package:mobile_tol_guard/app/domain/use_cases/auth/login.dart';
import 'package:mobile_tol_guard/core/database/user_db.dart';
import 'package:mobile_tol_guard/core/translator/translator.dart';
import 'package:mobile_tol_guard/core/util/security.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._login) : super(AuthInitial());
  final Login _login;

// example cubit if connect to backend service
  login({required String username, required String password}) async {
    try {
      var params = LoginParams(
          username: Security.encryptAes(username) ?? '',
          password: Security.encryptAes(password) ?? '');
      var res = await _login(params);
      res.fold((l) {
        emit(LoginFailed(l.message ?? translator.internalServerError));
      }, (r) async {
        var user = await UserDb.instance.getUser();
        if (user != null) {
          user.username = username;
          user.password = password;
          await UserDb.instance.updateUsers(user);
        }
        emit(LoginSuccess(r));
      });
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }
}
