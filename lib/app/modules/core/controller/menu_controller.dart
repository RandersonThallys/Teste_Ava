import 'package:mobx/mobx.dart';

part 'menu_controller.g.dart';

class MenuController = MenuControllerBase with _$MenuController;

abstract class MenuControllerBase with Store {
  @observable
  int currentIndex = 0;

  @action
  void onTabTapped(int index) {
    currentIndex = index;
  }
}
