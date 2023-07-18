import 'package:teste_ava/app/modules/core/models/user_model.dart';

abstract class UserDatasource {
  Future getAllUsersByEmail({required String email});
  Future<UserModel> save({required UserModel value});
  Future<UserModel> update({required UserModel value});
}
