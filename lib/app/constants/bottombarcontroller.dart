import 'package:get/get.dart';

class CustomBottomBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxInt selectedIndex = 0.obs;

  changeSelectedTab(int index) {
    selectedIndex.value = index;
  }
}
