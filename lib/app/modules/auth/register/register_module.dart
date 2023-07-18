import 'package:teste_ava/app/modules/auth/register/register_page.dart';
import 'package:teste_ava/app/modules/auth/register/register_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RegisterStore(authRepository: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const RegisterPage()),
  ];
}
