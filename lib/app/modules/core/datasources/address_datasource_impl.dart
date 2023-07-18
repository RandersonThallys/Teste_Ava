// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sqflite/sqflite.dart';

import 'package:teste_ava/app/modules/core/datasources/address_datasource.dart';
import 'package:teste_ava/app/modules/core/models/address_model.dart';

class AddressDatasourceSqflite implements AddressDatasource {
  final Database db;
  AddressDatasourceSqflite({
    required this.db,
  });

  @override
  Future<AddressModel> save({required AddressModel value}) async {
    try {
      var result = await db.rawInsert(
          'INSERT INTO address (cep, street, complement, neighborhood, locality, state, user_id) VALUES ("${value.cep}", "${value.street}", "${value.complement}", "${value.neighborhood}", "${value.locality}", "${value.state}", ${value.userId})');
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
  Future<List<Map<String, dynamic>>> selectByUserId(
      {required int userId}) async {
    List<Map<String, dynamic>> result = [];
    result =
        await db.rawQuery('SELECT * FROM address WHERE user_id=?', [userId]);
    return result;
  }

  @override
  Future<AddressModel> update({required AddressModel value}) async {
    try {
      var result = await db.rawUpdate(
          'UPDATE address SET cep = ?, street = ?, complement = ?, neighborhood = ?, locality = ?, state = ? WHERE id = ? ',
          [
            value.cep,
            value.street,
            value.complement,
            value.neighborhood,
            value.locality,
            value.state,
            value.id
          ]);
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
