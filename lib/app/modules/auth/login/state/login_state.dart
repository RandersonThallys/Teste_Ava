import 'package:teste_ava/app/modules/core/models/user_model.dart';

sealed class LoginState {
  final UserModel user;

  LoginState({required this.user});
}

class LoginSuccessState extends LoginState {
  LoginSuccessState({required super.user});
}

class LoginInitialState extends LoginState {
  LoginInitialState()
      : super(user: UserModel(name: '', email: '', password: ''));
}

class LoginLoadingState extends LoginState {
  LoginLoadingState({required super.user});
}

class LoginErrorState extends LoginState {
  final String messageError;
  LoginErrorState({required this.messageError, required super.user});
}
