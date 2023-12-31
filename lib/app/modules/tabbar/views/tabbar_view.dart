import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentweatherapp/app/services/responsive_size.dart';

import '../../fivedays/views/fivedays_view.dart';
import '../../today/views/today_view.dart';
import '../controllers/tabbar_controller.dart';

class TabbarView extends GetView<TabbarController> {
  const TabbarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 18.kh, left: 18.kw, right: 18.kw),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(
                      9.0,
                    ),
                  ),
                  child: TabBar(
                    controller: controller.selectedIndex.value,
                    // give the indicator a decoration (color and border radius)
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        7.0,
                      ),
                      color: const Color(0xFF636366),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: const Color(0xFF636366),
                    tabs: const [
                      Tab(
                        text: 'Today',
                      ),
                      Tab(
                        text: '5 Days Ahead',
                      ),
                    ],
                  ),
                ),
                // tab bar view here
                Expanded(
                  child: TabBarView(
                    controller: controller.selectedIndex.value,
                    children: [
                      // first tab bar view widget
                      TodayView(),
                      FivedaysView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
