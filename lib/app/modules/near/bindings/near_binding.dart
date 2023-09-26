import 'package:get/get.dart';

import '../controllers/near_controller.dart';

class NearBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NearController>(
      () => NearController(),
    );
  }
}
