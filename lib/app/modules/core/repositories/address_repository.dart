import 'package:multiple_result/multiple_result.dart';
import 'package:teste_ava/app/modules/core/exceptions/address_exception.dart';
import 'package:teste_ava/app/modules/core/models/address_model.dart';

abstract class AddressRepository {
  Future<Result<AddressModel, AddressException>> registerAddress(
      {required String cep,
      required String street,
      required String complement,
      required String neighborhood,
      required String locality,
      required String state,
      required int userId});
  Future<Result<AddressModel, AddressException>> updateAddress(
      {required int id,
      required String cep,
      required String street,
      required String complement,
      required String neighborhood,
      required String locality,
      required String state,
      required int userId});
  Future<Result<List<AddressModel>, AddressException>> getAllAddressById(
      {required int userId});
}
