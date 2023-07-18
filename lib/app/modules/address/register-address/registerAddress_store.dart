// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:teste_ava/app/modules/core/models/address_model.dart';
import 'package:teste_ava/app/modules/core/repositories/address_repository.dart';
import 'package:teste_ava/app/modules/home/home_store.dart';

part 'registerAddress_store.g.dart';

class RegisterAddressStore = _RegisterAddressStoreBase
    with _$RegisterAddressStore;

abstract class _RegisterAddressStoreBase with Store {
  final AddressRepository addressRepository;
  _RegisterAddressStoreBase({
    required this.addressRepository,
  });

  String cep = '';
  String street = '';
  String complement = '';
  String neighborhood = '';
  String locality = '';
  String state = '';

  late AddressModel? address;

  TextEditingController textEditingControllerCep = TextEditingController();
  TextEditingController textEditingControllerStreet = TextEditingController();
  TextEditingController textEditingControllerComplement =
      TextEditingController();
  TextEditingController textEditingControllerNeighborhood =
      TextEditingController();
  TextEditingController textEditingControllerLocality = TextEditingController();
  TextEditingController textEditingControllerState = TextEditingController();

  register() async {
    int userId = Modular.get<HomeStore>().user.id!;
    var result = await addressRepository.registerAddress(
        cep: textEditingControllerCep.text,
        street: textEditingControllerStreet.text,
        complement: textEditingControllerComplement.text,
        neighborhood: textEditingControllerNeighborhood.text,
        locality: textEditingControllerLocality.text,
        state: textEditingControllerState.text,
        userId: userId);
    result.when((success) => print('Endereço cadastrado com sucesso!'),
        (error) => print(error.message));
  }

  edit() async {
    int userId = Modular.get<HomeStore>().user.id!;
    var result = await addressRepository.updateAddress(
        id: address!.id!,
        cep: textEditingControllerCep.text,
        street: textEditingControllerStreet.text,
        complement: textEditingControllerComplement.text,
        neighborhood: textEditingControllerNeighborhood.text,
        locality: textEditingControllerLocality.text,
        state: textEditingControllerState.text,
        userId: userId);
    result.when((success) => print('Endereço alterado com sucesso!'),
        (error) => print(error.message));
  }
}
