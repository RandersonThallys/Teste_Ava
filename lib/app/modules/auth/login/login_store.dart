// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';
import 'package:teste_ava/app/modules/auth/login/state/login_state.dart';

import 'package:teste_ava/app/modules/core/repositories/auth_repository.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final AuthRepository authRepository;
  _LoginStoreBase({
    required this.authRepository,
  });

  String email = '';
  String password = '';

  @observable
  LoginState state = LoginInitialState();

  login() async {
    state = LoginLoadingState(user: state.user);
    var result = await authRepository.login(email: email, password: password);
    result.when(
        (success) => state = LoginSuccessState(user: success),
        (error) => state =
            LoginErrorState(messageError: error.message, user: state.user));
  }
}
