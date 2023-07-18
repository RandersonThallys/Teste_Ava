// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:multiple_result/src/result.dart';

import 'package:teste_ava/app/modules/core/datasources/user_datasource.dart';
import 'package:teste_ava/app/modules/core/exceptions/auth_exception.dart';
import 'package:teste_ava/app/modules/core/models/user_model.dart';
import 'package:teste_ava/app/modules/core/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final UserDatasource datasource;
  AuthRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Result<UserModel, AuthException>> login(
      {required String email, required String password}) async {
    try {
      var result = await datasource.getAllUsersByEmail(email: email);
      var user = UserModel.fromMap(result.first as Map<String, dynamic>);
      if (user.password == password) {
        return Success(user);
      } else {
        throw PasswordInvalidException(message: 'Invalid password!');
      }
    } on PasswordInvalidException catch (e) {
      return Error(e);
    } on AccountNotExistException catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<UserModel, AuthException>> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      var result = await datasource.save(
          value: UserModel(name: name, email: email, password: password));

      return Success(result);
    } on AuthException catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<UserModel, AuthException>> updatePassword(
      {required int id, required String password}) async {
    try {
      var result =
          await datasource.update(value: UserModel(id: id, password: password));

      return Success(result);
    } on AuthException catch (e) {
      return Error(e);
    }
  }
}
