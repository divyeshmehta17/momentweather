import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/today/bindings/today_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/services/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initGetServices();

  return runApp(GestureDetector(
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child: GetMaterialApp(
      //theme: AppTheme.light,
      //darkTheme: AppTheme.dark,
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      defaultTransition: Transition.fade,
      smartManagement: SmartManagement.full,
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      initialRoute: AppPages.INITIAL,
      initialBinding: TodayBinding(),
      getPages: AppPages.routes,
    ),
  ));
}

Future<void> initGetServices() async {
  await Get.putAsync<GetStorageService>(() => GetStorageService().initState());
}
