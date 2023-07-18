import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_ava/app/modules/address/register_address/register_address_module.dart';
import 'package:teste_ava/app/modules/home/home_module.dart';

class AddressModule extends Module {
  @override
  // TODO: implement imports
  List<Module> get imports => [HomeModule()];
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/register-address', module: RegisterAddressModule()),
  ];
}
