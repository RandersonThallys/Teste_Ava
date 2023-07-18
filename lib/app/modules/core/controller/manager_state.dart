import 'package:teste_ava/app/modules/core/models/user_model.dart';

sealed class ManagerState {
  final List<UserModel> users;

  ManagerState({
    required this.users,
  });
}

class InitialManagerState extends ManagerState {
  InitialManagerState() : super(users: []);
}

class SuccessManagerState extends ManagerState {
  SuccessManagerState({
    required super.users,
  });
}

class LoadingManagerState extends ManagerState {
  LoadingManagerState() : super(users: []);
}

class ErrorManagerState extends ManagerState {
  final String message;
  ErrorManagerState({
    required this.message,
  }) : super(users: []);
}
