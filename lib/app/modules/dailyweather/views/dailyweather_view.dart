import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dailyweather_controller.dart';

class DailyweatherView extends GetView<DailyweatherController> {
  const DailyweatherView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DailyweatherView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DailyweatherView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
