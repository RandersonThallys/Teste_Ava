import 'package:mobx/mobx.dart';
import 'package:teste_ava/app/modules/core/models/user_model.dart';
import 'package:teste_ava/app/modules/home/state/home_state.dart';

import '../core/repositories/address_repository.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final AddressRepository addressRepository;
  _HomeStoreBase({
    required this.addressRepository,
  });
  late UserModel user;

  @observable
  HomeState state = HomeInitialState();

  @action
  getAllAddressByUser(int id) async {
    state = HomeLoadingState(addressList: state.addressList);

    var result = await addressRepository.getAllAddressById(userId: id);
    Future.delayed(const Duration(milliseconds: 500));
    result.when(
        (success) => state = HomeSuccessState(addressList: success),
        (error) => state = HomeErrorState(
            addressList: state.addressList, messageError: error.message));
  }
}
