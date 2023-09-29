import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../module/currentweather.dart';
import '../../../services/dio/api_service.dart';

class TodayController extends GetxController {
  final Rx<WeatherData?> weatherData = Rx<WeatherData?>(null);
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString city = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getWeatherData();
    Geolocator
        .requestPermission(); // Fetch initial weather data when the controller is initialized
  }

  Future<void> getWeatherData() async {
    LocationPermission permission = await Geolocator.checkPermission();
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (permission == LocationPermission.denied || !isLocationEnabled) {
      print('Location is denied or disabled');
      Geolocator.requestPermission();
    }
    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      latitude.value = position.latitude;
      longitude.value = position.longitude;

      // Use the geolocator package to get the location details
      await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      ).then((List<Placemark> placemarks) async {
        Placemark place = placemarks[0];
        city.value = place.locality ?? '';
        print(place);
      });
    } catch (e) {
      print('Error fetching location: $e');
    }

    final data = await APIManager.getWeatherData(
      latitude: latitude.toDouble(),
      longitude: longitude.toDouble(),
      cityName: city.toString(),
    );
    print('Position: ${latitude}, ${longitude} City:${city}');
    weatherData.value = data;
  }
}
