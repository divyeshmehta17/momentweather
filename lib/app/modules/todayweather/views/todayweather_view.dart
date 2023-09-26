import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/todayweather_controller.dart';

class TodayweatherView extends GetView<TodayweatherController> {
  const TodayweatherView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodayweatherView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TodayweatherView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
