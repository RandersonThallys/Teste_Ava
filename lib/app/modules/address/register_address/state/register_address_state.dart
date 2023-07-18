import 'package:teste_ava/app/modules/core/models/address_model.dart';

sealed class RegisterAddressState {
  final AddressModel address;

  RegisterAddressState({required this.address});
}

class RegisterAddressSuccessState extends RegisterAddressState {
  RegisterAddressSuccessState({required super.address});
}

class RegisterAddressInitialState extends RegisterAddressState {
  RegisterAddressInitialState()
      : super(
          address: AddressModel(
            cep: '',
            street: '',
            complement: '',
            neighborhood: '',
            locality: '',
            state: '',
            userId: 0,
          ),
        );
}

class RegisterAddressLoadingState extends RegisterAddressState {
  RegisterAddressLoadingState({required super.address});
}

class RegisterAddressErrorState extends RegisterAddressState {
  final String messageError;
  RegisterAddressErrorState(
      {required this.messageError, required super.address});
}
