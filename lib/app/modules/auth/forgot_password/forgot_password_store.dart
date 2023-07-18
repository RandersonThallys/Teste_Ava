import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:teste_ava/app/modules/core/repositories/auth_repository.dart';
import 'package:teste_ava/app/modules/home/home_store.dart';

part 'forgot_password_store.g.dart';

class ForgotPasswordStore = _ForgotPasswordStoreBase with _$ForgotPasswordStore;

abstract class _ForgotPasswordStoreBase with Store {
  final AuthRepository authRepository;
  _ForgotPasswordStoreBase({
    required this.authRepository,
  });

  String newPassword = '';

  TextEditingController textEditingControllerPassword = TextEditingController();

  edit() async {
    int userId = Modular.get<HomeStore>().user.id!;
    var result = await authRepository.updatePassword(
        id: userId, password: textEditingControllerPassword.text);
    result.when((success) => print('Senha alterada com sucesso!'),
        (error) => print(error.message));
  }
}
