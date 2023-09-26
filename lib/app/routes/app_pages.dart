import 'package:get/get.dart';

import '../modules/dailyweather/bindings/dailyweather_binding.dart';
import '../modules/dailyweather/views/dailyweather_view.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/near/bindings/near_binding.dart';
import '../modules/near/views/near_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/todayweather/bindings/todayweather_binding.dart';
import '../modules/todayweather/views/todayweather_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.TODAYWEATHER,
      page: () => const TodayweatherView(),
      binding: TodayweatherBinding(),
    ),
    GetPage(
      name: _Paths.DAILYWEATHER,
      page: () => const DailyweatherView(),
      binding: DailyweatherBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => const FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.NEAR,
      page: () => const NearView(),
      binding: NearBinding(),
    ),
  ];
}
