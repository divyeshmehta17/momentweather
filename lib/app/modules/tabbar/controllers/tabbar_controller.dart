import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement TabbarController
  final Rx<TabController?> selectedIndex = Rx<TabController?>(null);

  final count = 0.obs;
  void changeSelectedTab(int index) {
    selectedIndex.value = TabController(length: 2, vsync: this);
    selectedIndex.value?.index = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
