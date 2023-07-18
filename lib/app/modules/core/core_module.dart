import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teste_ava/app/modules/core/database/db.dart';
import 'package:teste_ava/app/modules/core/datasources/address_datasource.dart';
import 'package:teste_ava/app/modules/core/datasources/address_datasource_impl.dart';
import 'package:teste_ava/app/modules/core/datasources/user_datasource.dart';
import 'package:teste_ava/app/modules/core/datasources/user_datasource_impl.dart';
import 'package:teste_ava/app/modules/core/repositories/address_repository.dart';
import 'package:teste_ava/app/modules/core/repositories/address_repository_impl.dart';
import 'package:teste_ava/app/modules/core/repositories/auth_repository.dart';
import 'package:teste_ava/app/modules/core/repositories/auth_repository_impl.dart';

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    AsyncBind<Database>((i) async => await DB.instance.database, export: true),
    Bind.factory<UserDatasource>((i) => UserDatasourceSqflite(db: i()),
        export: true),
    Bind.factory<AuthRepository>((i) => AuthRepositoryImpl(datasource: i()),
        export: true),
    Bind.factory<AddressDatasource>((i) => AddressDatasourceSqflite(db: i()),
        export: true),
    Bind.factory<AddressRepository>(
        (i) => AddressRepositoryImpl(datasource: i()),
        export: true),
  ];

  @override
  final List<ModularRoute> routes = [];
}
