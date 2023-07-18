import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_ava/app/modules/auth/forgot_password/forgot_password_store.dart';
import 'package:flutter/material.dart';
import 'package:teste_ava/app/modules/core/components/theme/app_typography.dart';
import 'package:teste_ava/app/modules/core/components/widgets/custom_button_widget.dart';
import 'package:teste_ava/app/modules/core/components/widgets/custom_textfield_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String title;
  const ForgotPasswordPage({Key? key, this.title = 'Alterar senha'})
      : super(key: key);
  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final ForgotPasswordStore store = Modular.get();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Change Password',
              style: AppTypography().title,
            ),
            leading: const BackButton(
              color: Colors.black,
            )),
        body: Observer(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 100.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      CustomTextfieldWidget(
                        controller: store.textEditingControllerPassword,
                        onChanged: (value) => store.newPassword = value!,
                        isPassword: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter with your new password';
                          }
                          return null;
                        },
                        labelText: 'New Password',
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      CustomButtonWidget(
                          fullWidth: true,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await store.edit();
                              Modular.to.pushReplacementNamed('/auth/login/');
                            }
                          },
                          widget: Text(
                            'Update password',
                            style: AppTypography().content,
                          ))
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
