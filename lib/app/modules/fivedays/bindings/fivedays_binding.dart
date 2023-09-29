import 'package:get/get.dart';

import '../controllers/fivedays_controller.dart';

class FivedaysBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FivedaysController>(
      () => FivedaysController(),
    );
  }
}
