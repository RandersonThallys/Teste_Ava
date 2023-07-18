import 'package:teste_ava/app/modules/core/models/user_model.dart';

sealed class ForgotPasswordState {
  final UserModel user;

  ForgotPasswordState({required this.user});
}

class ForgotPasswordSuccessState extends ForgotPasswordState {
  ForgotPasswordSuccessState({required super.user});
}

class ForgotPasswordInitialState extends ForgotPasswordState {
  ForgotPasswordInitialState()
      : super(
          user: UserModel(
            password: '',
          ),
        );
}

class ForgotPasswordLoadingState extends ForgotPasswordState {
  ForgotPasswordLoadingState({required super.user});
}

class ForgotPasswordErrorState extends ForgotPasswordState {
  final String messageError;
  ForgotPasswordErrorState({required this.messageError, required super.user});
}
