import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_ava/app/modules/auth/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:teste_ava/app/modules/auth/login/state/login_state.dart';
import 'package:teste_ava/app/modules/core/components/widgets/custom_button_widget.dart';
import 'package:teste_ava/app/modules/core/components/widgets/custom_textfield_widget.dart';
import 'package:teste_ava/app/modules/core/components/theme/app_typography.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final LoginStore store = Modular.get();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Observer(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Hi, Wecome to ',
                    style: AppTypography().title,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Address Manager! 🌍\n',
                        style: AppTypography().label3,
                      ),
                      TextSpan(
                        text: 'Here you manage your addresses',
                        style: AppTypography().subTitle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                        height: 40.0,
                      ),
                      CustomTextfieldWidget(
                        labelText: 'Password',
                        onChanged: (value) => store.password = value!,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter with your password';
                          }
                          return null;
                        },
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
                CustomButtonWidget(
                  fullWidth: true,
                  onPressed: () async {
                    await store.login();
                    if (_formKey.currentState!.validate()) {
                      if (store.state is LoginSuccessState) {
                        Modular.to.navigate('/home/',
                            arguments: {'user': store.state.user});
                      } else if (store.state is LoginErrorState) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Attention!"),
                                content: Text((store.state as LoginErrorState)
                                    .messageError),
                                actions: [
                                  TextButton(
                                      onPressed: () => Modular.to.pop(),
                                      child: const Text('Return'))
                                ],
                              );
                            });
                      }
                    }
                  },
                  widget: store.state is LoginLoadingState
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Login',
                          style: AppTypography().content,
                        ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Modular.to.pushNamed('/auth/register/');
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: AppTypography().label2,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Sign Up', style: AppTypography().label),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
