import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_ava/app/modules/auth/register/register_store.dart';
import 'package:flutter/material.dart';
import 'package:teste_ava/app/modules/core/components/theme/app_typography.dart';
import 'package:teste_ava/app/modules/core/components/widgets/custom_button_widget.dart';
import 'package:teste_ava/app/modules/core/components/widgets/custom_textfield_widget.dart';

class RegisterPage extends StatefulWidget {
  final String title;
  const RegisterPage({Key? key, this.title = 'RegisterPage'}) : super(key: key);
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final RegisterStore store = Modular.get();
  String _password = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Create an account\n',
                    style: AppTypography().title,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'manage and add your addresses today!',
                        style: AppTypography().subTitle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextfieldWidget(
                  labelText: 'Name',
                  onChanged: (value) => store.name = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter with your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextfieldWidget(
                  labelText: 'Email',
                  onChanged: (value) => store.email = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter with your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextfieldWidget(
                  labelText: 'Password',
                  isPassword: true,
                  onChanged: (value) => _password = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter with your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextfieldWidget(
                  labelText: 'Confirm your password',
                  isPassword: true,
                  onChanged: (value) => store.password = value!,
                  validator: (value) {
                    if (value != _password) {
                      return 'Confirm password not matching';
                    }
                    if (value!.isEmpty) {
                      return 'Please confirm your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomButtonWidget(
                  fullWidth: true,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await store.register();
                      Modular.to.pop();
                    }
                  },
                  widget: Text('Sign Up', style: AppTypography().content),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Modular.to.pop();
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: AppTypography().label2,
                        children: <TextSpan>[
                          TextSpan(text: 'Login', style: AppTypography().label),
                        ],
                      ),
                    ),
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
