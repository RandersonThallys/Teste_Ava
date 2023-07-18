// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';

import 'package:teste_ava/app/modules/core/repositories/auth_repository.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStoreBase with _$RegisterStore;

abstract class _RegisterStoreBase with Store {
  final AuthRepository authRepository;
  _RegisterStoreBase({
    required this.authRepository,
  });

  String name = '';

  String email = '';
  String password = '';

  register() async {
    var result = await authRepository.registerUser(
        name: name, email: email, password: password);
    result.when(
        (success) => print('Deu certo'), (error) => print('Deu errado'));
  }
}
