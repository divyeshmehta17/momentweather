import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../services/dio/api_service.dart';

class NearController extends GetxController {
  final Dio _dio = Dio();

  var isLoading = false.obs;
  var weatherData = {}.obs;
  var hourlyData = {}.obs;
  var fivedaysData = {}.obs;
  String? subLocality;

  RxBool isLocationFetched = true.obs;

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLocation();
    fetchWeatherData();
    fetchhourlyWeatherData();
    fetchdailyWeatherData();
    print('daily: $fivedaysData');
    print(weatherData);
  }

  Future<void> fetchWeatherData() async {
    APIManager.getcurrentweatherdata(
      latitude: latitude.toString(),
      longitude: longitude.toString(),
    ).then((value) => {weatherData(value.data), print(value.data)});
  }

  Future<void> fetchhourlyWeatherData() async {
    APIManager.gethourlyweatherdata(
      latitude: latitude.toString(),
      longitude: longitude.toString(),
    ).then((value) => {hourlyData(value.data), print(value.data)});
  }

  Future<void> fetchdailyWeatherData() async {
    APIManager.getfivedayweatherdata(
      latitude: latitude.toString(),
      longitude: longitude.toString(),
    ).then((value) => {fivedaysData(value.data), print(value.data)});
  }

  Future<void> fetchLocation() async {
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
              position?.latitude ?? 0, position?.longitude ?? 0,
              localeIdentifier: 'enUS')
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        subLocality = place.locality ?? '';
      });
    } catch (e) {
      print('Error fetching location: $e');
    }
  }
}
