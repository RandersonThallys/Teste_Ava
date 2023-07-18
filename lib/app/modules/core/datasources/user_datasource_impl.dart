// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sqflite/sqflite.dart';
import 'package:teste_ava/app/modules/core/datasources/user_datasource.dart';
import 'package:teste_ava/app/modules/core/models/user_model.dart';

import '../exceptions/auth_exception.dart';

class UserDatasourceSqflite implements UserDatasource {
  final Database db;
  UserDatasourceSqflite({
    required this.db,
  });

  @override
  Future<List<Map>> getAllUsersByEmail({required String email}) async {
    try {
      List<Map> result = [];
      result = await db.rawQuery('SELECT * FROM user WHERE email=?', [email]);
      if (result.isNotEmpty) {
        return result;
      } else {
        throw AccountNotExistException(
            message: 'There is no account associated with this email');
      }
    } on AccountNotExistException catch (e) {
      throw AccountNotExistException(
          message: e.message, stackTrace: e.stackTrace);
    }
  }

  @override
  Future<UserModel> save({required UserModel value}) async {
    try {
      var result = await db.rawInsert(
          'INSERT INTO user (name, email, password) VALUES ("${value.name}", "${value.email}", "${value.password}")');
      if (result != 0) {
        return value.copyWith(id: result);
      } else {
        throw Exception('ERRO AO SALVAR NO BANCO');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> update({required UserModel value}) async {
    try {
      var result = await db.rawUpdate(
          'UPDATE user SET password = ? WHERE id = ? ',
          [value.password, value.id]);
      if (result != 0) {
        return value;
      } else {
        throw Exception('ERRO AO ATUALIZAR O BANCO');
      }
    } catch (e) {
      rethrow;
    }
  }
}
