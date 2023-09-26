import 'package:flutter/material.dart';
import 'package:momentweatherapp/app/services/responsive_size.dart';

import '../modules/near/views/firvedaysahead.dart';
import '../modules/near/views/today.dart';

class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 18.kh, left: 18.kw, right: 18.kw),
          child: Column(
            children: [
              // give the tab bar a height [can change hheight to preferred height]
              Container(
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(
                    9.0,
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      7.0,
                    ),
                    color: Color(0xFF636366),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Color(0xFF636366),
                  tabs: [
                    // first tab [you can add an icon using the icon property]
                    Tab(
                      text: 'Today',
                    ),

                    // second tab [you can add an icon using the icon property]
                    Tab(
                      text: '5 Days Ahead',
                    ),
                  ],
                ),
              ),
              // tab bar view here
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // first tab bar view widget
                    TodayView(),
                    FiveDaysAhead()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
