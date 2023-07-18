import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_ava/app/modules/auth/login/login_module.dart';
import 'package:teste_ava/app/modules/auth/register/register_module.dart';
import 'package:teste_ava/app/modules/auth/forgot_password/forgot_password_module.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/register', module: RegisterModule()),
    ModuleRoute('/forgot-password', module: ForgotPasswordModule()),
  ];
}
