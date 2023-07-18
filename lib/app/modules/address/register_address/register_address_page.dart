import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:teste_ava/app/modules/address/register_address/register_address_store.dart';
import 'package:teste_ava/app/modules/core/components/theme/app_typography.dart';
import 'package:teste_ava/app/modules/core/components/widgets/custom_button_widget.dart';
import 'package:teste_ava/app/modules/core/components/widgets/custom_textfield_widget.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            isEdit == true ? 'Edit address' : 'New address',
            style: AppTypography().title,
          ),
          leading: const BackButton(
            color: Colors.black,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                CustomTextfieldWidget(
                  labelText: 'Cep',
                  maskTypes: MaskTypes.cep,
                  controller: store.textEditingControllerCep,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter with your Cep';
                    }
                  },
                  onChanged: (value) async {
                    if (value!.length == 9) {
                      final resultCep =
                          await ViaCepService.fetchCep(cep: value);
                      if (resultCep.erro == true) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Attention!"),
                                content: const Text('Cep not exist'),
                                actions: [
                                  TextButton(
                                      onPressed: () => Modular.to.pop(),
                                      child: const Text('Return'))
                                ],
                              );
                            });
                      }
                      store.textEditingControllerCep.text = resultCep.cep!;
                      store.textEditingControllerStreet.text =
                          resultCep.street!.isNotEmpty
                              ? resultCep.street!
                              : 'no street';
                      store.textEditingControllerComplement.text =
                          resultCep.complement!.isNotEmpty
                              ? resultCep.complement!
                              : 'no complement';
                      store.textEditingControllerNeighborhood.text =
                          resultCep.neighborhood!.isNotEmpty
                              ? resultCep.neighborhood!
                              : 'no neighborhood';
                      store.textEditingControllerLocality.text =
                          resultCep.locality!;
                      store.textEditingControllerState.text = resultCep.state!;
                    }
                    store.cep = value;
                  },
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomTextfieldWidget(
                  controller: store.textEditingControllerStreet,
                  onChanged: (value) => store.street = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter with your street';
                    }
                  },
                  labelText: 'Street',
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomTextfieldWidget(
                  controller: store.textEditingControllerComplement,
                  onChanged: (value) => store.complement = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter with your complement';
                    }
                  },
                  labelText: 'Complement',
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomTextfieldWidget(
                  controller: store.textEditingControllerNeighborhood,
                  onChanged: (value) => store.neighborhood = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter with your neighborhood';
                    }
                  },
                  labelText: 'Neighborhood',
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomTextfieldWidget(
                  controller: store.textEditingControllerLocality,
                  onChanged: (value) => store.locality = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter with your locality';
                    }
                  },
                  labelText: 'Locality',
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomTextfieldWidget(
                  controller: store.textEditingControllerState,
                  onChanged: (value) => store.state = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter with your state';
                    }
                  },
                  labelText: 'State',
                ),
                const SizedBox(
                  height: 50.0,
                ),
                CustomButtonWidget(
                  fullWidth: true,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (isEdit) {
                        await store.edit();
                      } else {
                        await store.register();
                      }

                      Modular.to.pop();
                    }
                  },
                  widget: Text(
                    isEdit == true ? 'Finish editing' : 'Register address',
                    style: AppTypography().content,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
