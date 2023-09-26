import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/image_constant.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/near/views/near_view.dart';
import '../modules/settings/views/settings_view.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    NearView(),
    FavoriteView(),
    SettingsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
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
              _selectedIndex == 0,
            ),
            label: 'Near',
          ),
          BottomNavigationBarItem(
            icon: _buildShaderMask(
              Image.asset(
                ImageConstant.pngfav,
              ),
              _selectedIndex == 1,
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
              _selectedIndex == 2,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        //selectedItemColor: Colors.black,
        unselectedItemColor: Color(0xFF999999),
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
