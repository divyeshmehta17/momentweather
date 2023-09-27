import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../modules/favorite/views/favorite_view.dart';
import '../modules/near/views/near_view.dart';
import '../modules/settings/views/settings_view.dart';
import 'bottombarcontroller.dart';
import 'image_constant.dart';

final List<Widget> _widgetOptions = <Widget>[
  NearView(),
  FavoriteView(),
  SettingsView(),
];

class CustomBottomBar extends StatelessWidget {
  final CustomBottomBarController controller =
      Get.put(CustomBottomBarController());

  ShaderMask _buildShaderMask(Widget child, bool isSelected) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: isSelected
              ? [Color(0xFF0199EF), Color(0xFF295FE9), Color(0xFF5C15F5)]
              : [Color(0xFF999999), Color(0xFF999999)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bounds);
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(CustomBottomBarController());
    return Scaffold(
      body: _widgetOptions.elementAt(controller.selectedIndex.value),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildShaderMask(
              SvgPicture.asset(
                ImageConstant.svgnear,
                width: 24,
                height: 24,
              ),
              controller.selectedIndex.value == 0,
            ),
            label: 'Near',
          ),
          BottomNavigationBarItem(
            icon: _buildShaderMask(
              Image.asset(
                ImageConstant.pngfav,
              ),
              controller.selectedIndex.value == 1,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: _buildShaderMask(
              SvgPicture.asset(
                ImageConstant.svgsettings,
                width: 24,
                height: 24,
              ),
              controller.selectedIndex.value == 2,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: controller.selectedIndex.value,
        //selectedItemColor: Colors.black,
        unselectedItemColor: Color(0xFF999999),
        showUnselectedLabels: true,
        onTap: controller.changeSelectedTab(0),
      ),
    );
  }
}
