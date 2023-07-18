import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CustomMenuWidget extends StatelessWidget {
  const CustomMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final BottomMenuController controller = BottomMenuController();
    List<Widget> screens = [
      // const HomePage(),
      // const CategoriesPage(),
      // const AnnouncePage(),
      // const FavoritesPage(),
      // const ProfilePage(),
    ];
    return Observer(
      builder: (context) {
        return Scaffold(
          //body: Observer(builder: (_) => screens[controller.currentIndex]),
          bottomNavigationBar: BottomNavigationBar(
            //currentIndex: controller.currentIndex,
            //onTap: controller.onTabTapped,
            type: BottomNavigationBarType.fixed,
            //selectedLabelStyle: AppTypography().textBottomMenu,
            //unselectedLabelStyle: AppTypography().textBottomMenu,
            //selectedItemColor: AppColors().textLightBlue,
            //unselectedItemColor: AppColors().textGray,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Novo endereço',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map_rounded),
                label: 'Novo endereço',
              ),
            ],
          ),
        );
      },
    );
  }
}
