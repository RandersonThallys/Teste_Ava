import 'package:teste_ava/app/modules/core/models/address_model.dart';

sealed class HomeState {
  final List<AddressModel> addressList;

  HomeState({required this.addressList});
}

class HomeSuccessState extends HomeState {
  HomeSuccessState({required super.addressList});
}

class HomeInitialState extends HomeState {
  HomeInitialState() : super(addressList: []);
}

class HomeLoadingState extends HomeState {
  HomeLoadingState({required super.addressList});
}

class HomeErrorState extends HomeState {
  final String messageError;
  HomeErrorState({required super.addressList, required this.messageError});
}
