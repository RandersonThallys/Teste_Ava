import 'package:teste_ava/app/modules/core/models/address_model.dart';

abstract class AddressDatasource {
  Future<AddressModel> save({required AddressModel value});
  Future<List<Map<String, dynamic>>> selectByUserId({required int userId});
  Future<AddressModel> update({required AddressModel value});
}
