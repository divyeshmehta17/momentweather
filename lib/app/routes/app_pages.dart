import 'package:get/get_navigation/src/routes/get_route.dart';

import '../modules/tabbar/bindings/tabbar_binding.dart';
import '../modules/tabbar/views/tabbar_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.TABBAR;

  static final routes = [
    GetPage(
      name: _Paths.TABBAR,
      page: () => const TabbarView(),
      binding: TabbarBinding(),
    ),
  ];
}
