import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_ava/app/modules/address/register-address/registerAddress_page.dart';
import 'package:teste_ava/app/modules/address/register-address/registerAddress_store.dart';

class RegisterAddressModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RegisterAddressStore(addressRepository: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const RegisterAddressPage()),
  ];
}
