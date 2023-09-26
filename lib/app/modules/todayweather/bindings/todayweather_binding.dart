import 'package:get/get.dart';

import '../controllers/todayweather_controller.dart';

class TodayweatherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodayweatherController>(
      () => TodayweatherController(),
    );
  }
}
