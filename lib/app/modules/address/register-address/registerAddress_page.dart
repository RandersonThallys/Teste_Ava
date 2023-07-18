import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:teste_ava/app/modules/address/register-address/registerAddress_store.dart';
import 'package:teste_ava/app/modules/core/models/address_model.dart';
import 'package:teste_ava/app/modules/core/services/http/cep_service.dart';

class RegisterAddressPage extends StatefulWidget {
  const RegisterAddressPage({
    Key? key,
  }) : super(key: key);

  @override
  RegisterAddressPageState createState() => RegisterAddressPageState();
}

class RegisterAddressPageState extends State<RegisterAddressPage> {
  late AddressModel? address;
  bool isEdit = false;

  @override
  void initState() {
    if (Modular.args.data != null) {
      store.address = Modular.args.data['address'];
      isEdit = Modular.args.data['isEdit'] ?? false;
    }

    if (isEdit) {
      store.textEditingControllerCep.text = store.address!.cep;
      store.textEditingControllerStreet.text = store.address!.street;
      store.textEditingControllerComplement.text = store.address!.complement;
      store.textEditingControllerNeighborhood.text =
          store.address!.neighborhood;
      store.textEditingControllerLocality.text = store.address!.locality;
      store.textEditingControllerState.text = store.address!.state;
    }
    super.initState();
  }

  final RegisterAddressStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const Text('Cadastro de Endereço'),
              const SizedBox(
                height: 100.0,
              ),
              TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(8),
                ],
                keyboardType: TextInputType.number,
                controller: store.textEditingControllerCep,
                onChanged: (value) async {
                  print("tamanho: ${value.length}");
                  print("valor: $value");
                  if (value.length == 8) {
                    final resultCep = await ViaCepService.fetchCep(cep: value);
                    store.textEditingControllerCep.text = resultCep.cep!;
                    store.textEditingControllerStreet.text =
                        resultCep.street!.isNotEmpty
                            ? resultCep.street!
                            : 'Sem rua';
                    store.textEditingControllerComplement.text =
                        resultCep.complement!.isNotEmpty
                            ? resultCep.complement!
                            : 'Sem complemento';
                    store.textEditingControllerNeighborhood.text =
                        resultCep.neighborhood!.isNotEmpty
                            ? resultCep.neighborhood!
                            : 'Sem bairro';
                    store.textEditingControllerLocality.text =
                        resultCep.locality!;
                    store.textEditingControllerState.text = resultCep.state!;
                  }
                  store.cep = value;
                },
                decoration: const InputDecoration(label: Text('CEP')),
              ),
              const SizedBox(
                height: 50.0,
              ),
              TextField(
                controller: store.textEditingControllerStreet,
                onChanged: (value) => store.street = value,
                decoration: const InputDecoration(label: Text('Rua')),
              ),
              const SizedBox(
                height: 50.0,
              ),
              TextField(
                controller: store.textEditingControllerComplement,
                onChanged: (value) => store.complement = value,
                decoration: const InputDecoration(label: Text('Complemento')),
              ),
              const SizedBox(
                height: 50.0,
              ),
              TextField(
                controller: store.textEditingControllerNeighborhood,
                onChanged: (value) => store.neighborhood = value,
                decoration: const InputDecoration(label: Text('Bairro')),
              ),
              const SizedBox(
                height: 50.0,
              ),
              TextField(
                controller: store.textEditingControllerLocality,
                onChanged: (value) => store.locality = value,
                decoration: const InputDecoration(label: Text('Localidade')),
              ),
              const SizedBox(
                height: 50.0,
              ),
              TextField(
                controller: store.textEditingControllerState,
                onChanged: (value) => store.state = value,
                decoration: const InputDecoration(label: Text('Estado')),
              ),
              const SizedBox(
                height: 50.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (isEdit) {
                    await store.edit();
                  } else {
                    await store.register();
                  }

                  Modular.to.navigate('/home/');
                },
                child: const Text('Cadastrar endereço'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
