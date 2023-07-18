// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:multiple_result/src/result.dart';
import 'package:teste_ava/app/modules/core/datasources/address_datasource.dart';
import 'package:teste_ava/app/modules/core/exceptions/address_exception.dart';

import 'package:teste_ava/app/modules/core/models/address_model.dart';
import 'package:teste_ava/app/modules/core/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressDatasource datasource;
  AddressRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Result<AddressModel, AddressException>> registerAddress(
      {required String cep,
      required String street,
      required String complement,
      required String neighborhood,
      required String locality,
      required String state,
      required int userId}) async {
    try {
      var result = await datasource.save(
          value: AddressModel(
              cep: cep,
              street: street,
              complement: complement,
              neighborhood: neighborhood,
              locality: locality,
              state: state,
              userId: userId));

      return Success(result);
    } on AddressException catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<AddressModel, AddressException>> updateAddress(
      {required int id,
      required String cep,
      required String street,
      required String complement,
      required String neighborhood,
      required String locality,
      required String state,
      required int userId}) async {
    try {
      var result = await datasource.update(
          value: AddressModel(
              id: id,
              cep: cep,
              street: street,
              complement: complement,
              neighborhood: neighborhood,
              locality: locality,
              state: state,
              userId: userId));

      return Success(result);
    } on AddressException catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<List<AddressModel>, AddressException>> getAllAddressById(
      {required int userId}) async {
    try {
      var result = await datasource.selectByUserId(userId: userId);
      var address = result.map((e) => AddressModel.fromMap(e)).toList();
      return Success(address);
    } on AddressException catch (e) {
      return Error(e);
    }
  }
}
