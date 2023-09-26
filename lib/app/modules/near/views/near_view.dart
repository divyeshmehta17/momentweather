import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/commontabbar.dart';
import '../controllers/near_controller.dart';

class NearView extends GetView<NearController> {
  const NearView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(NearController());
    return Scaffold(body: CustomTabBar());
  }
}
