import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_ava/app/modules/core/components/theme/app_colors.dart';
import 'package:teste_ava/app/modules/core/components/theme/app_typography.dart';
import 'package:teste_ava/app/modules/core/components/widgets/custom_button_widget.dart';
import 'package:teste_ava/app/modules/home/state/home_state.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Meus Endereços'}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeStore store;

  @override
  void initState() {
    super.initState();

    store = Modular.get<HomeStore>();
    store.user = Modular.args.data['user'];
    store.getAllAddressByUser(store.user.id!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'My addresses',
                    style: AppTypography().title,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                          color: AppColors().purple,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                      child: PopupMenuButton<int>(
                        splashRadius: 20.0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        color: AppColors().purple,
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        onSelected: (item) => onSelected(context, item),
                        itemBuilder: (context) => [
                          PopupMenuItem<int>(
                            child: Center(
                              child: Text(
                                store.user.name!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                    color: Colors.white70),
                              ),
                            ),
                          ),
                          const PopupMenuDivider(
                            height: 10.0,
                          ),
                          const PopupMenuItem<int>(
                            value: 0,
                            child: Row(
                              children: [
                                Text(
                                  'New address',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Icon(Icons.fmd_good_rounded),
                              ],
                            ),
                          ),
                          const PopupMenuItem<int>(
                            value: 1,
                            child: Row(
                              children: [
                                Text(
                                  'Change Password',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Icon(Icons.key),
                              ],
                            ),
                          ),
                          const PopupMenuItem<int>(
                            value: 2,
                            child: Row(
                              children: [
                                Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Icon(Icons.logout),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors().purple,
          label: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('New Address'),
                Icon(Icons.add),
              ]),
          onPressed: () {
            Modular.to
                .pushNamed('/address/register-address/')
                .then((value) => store.getAllAddressByUser(store.user.id!));
          },
        ),
        body: Observer(builder: (_) {
          var state = store.state;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: switch (state) {
              HomeInitialState() => Container(),
              HomeLoadingState() => const Center(
                  child: CircularProgressIndicator(),
                ),
              HomeSuccessState(:final addressList) => addressList.isNotEmpty
                  ? ListView.builder(
                      itemCount: addressList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 230, 230, 230),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                                color: AppColors().purple, width: 2.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'CEP: ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' ${addressList[index].cep}',
                                        style: TextStyle(
                                            color: AppColors().purple,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Street: ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' ${addressList[index].street}',
                                        style: TextStyle(
                                            color: AppColors().purple,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Complement: ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            ' ${addressList[index].complement}',
                                        style: TextStyle(
                                            color: AppColors().purple,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Neighborhood: ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            ' ${addressList[index].neighborhood}',
                                        style: TextStyle(
                                            color: AppColors().purple,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Locality: ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' ${addressList[index].locality}',
                                        style: TextStyle(
                                            color: AppColors().purple,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'State: ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' ${addressList[index].state}',
                                        style: TextStyle(
                                            color: AppColors().purple,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CustomButtonWidget(
                                    onPressed: () {
                                      Modular.to.pushNamed(
                                          '/address/register-address/',
                                          arguments: {
                                            'address': addressList[index],
                                            'isEdit': true,
                                          }).then((value) => store
                                          .getAllAddressByUser(store.user.id!));
                                    },
                                    widget: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Edit address',
                                          style: AppTypography().content,
                                        ),
                                        const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                  : Center(
                      child: Text(
                      'There are no registered addresses yet...',
                      style: AppTypography().label2,
                    )),
              HomeErrorState() => Container(),
            },
          );
          // return Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child:
          //   ),
        }),
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Modular.to
            .pushNamed('/address/register-address/')
            .then((value) => store.getAllAddressByUser(store.user.id!));
        break;
      case 1:
        Modular.to.pushNamed('/auth/forgot-password/');
        break;
      case 2:
        Modular.to.pushReplacementNamed('/auth/login/');
        break;
    }
  }
}
