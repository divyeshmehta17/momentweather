import 'package:get/get.dart';

import '../controllers/dailyweather_controller.dart';

class DailyweatherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DailyweatherController>(
      () => DailyweatherController(),
    );
  }
}
