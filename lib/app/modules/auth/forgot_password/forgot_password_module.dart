import 'package:teste_ava/app/modules/auth/forgot_password/forgot_password_page.dart';
import 'package:teste_ava/app/modules/auth/forgot_password/forgot_password_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ForgotPasswordModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ForgotPasswordStore(authRepository: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const ForgotPasswordPage()),
  ];
}
