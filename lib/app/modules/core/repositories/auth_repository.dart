import 'package:multiple_result/multiple_result.dart';
import 'package:teste_ava/app/modules/core/exceptions/auth_exception.dart';
import 'package:teste_ava/app/modules/core/models/user_model.dart';

abstract class AuthRepository {
  Future<Result<UserModel, AuthException>> login(
      {required String email, required String password});
  Future<Result<UserModel, AuthException>> registerUser(
      {required String name, required String email, required String password});
  Future<Result<UserModel, AuthException>> updatePassword(
      {required int id, required String password});
}
