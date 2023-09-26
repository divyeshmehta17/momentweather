import 'package:get/get.dart';
import 'package:momentweatherapp/app/components/custombottomnavigationbar.dart';

import '../../near/controllers/near_controller.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  final NearController nearController = Get.put(NearController());
  @override
  void onInit() {
    super.onInit();
    nearController.fetchWeatherData();
    nearController.fetchLocation();
    Future.delayed(Duration(seconds: 5), () => Get.to(CustomBottomBar()));
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
