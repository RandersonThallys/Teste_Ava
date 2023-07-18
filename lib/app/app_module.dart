import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_ava/app/modules/address/address_module.dart';
import 'package:teste_ava/app/modules/auth/auth_module.dart';
import 'package:teste_ava/app/modules/core/core_module.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/auth', module: AuthModule(), guards: [InitialGuard()]),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/address', module: AddressModule()),
  ];
}

class InitialGuard extends RouteGuard {
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    await Modular.isModuleReady<AppModule>();
    return true;
  }
}
