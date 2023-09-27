import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../services/dio/api_service.dart';

class NearController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var weatherData = {}.obs;
  RxString subLocality = ''.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  final Rx<TabController?> selectedIndex = Rx<TabController?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLocation();
  }

  void changeSelectedTab(int index) {
    selectedIndex.value = TabController(length: 2, vsync: this);
    selectedIndex.value?.index = index;
  }

  Future<void> fetchWeatherData() async {
    isLoading.value = true;

    APIManager.getcurrentweatherdata(
      latitude: latitude.toString(),
      longitude: longitude.toString(),
    ).then((value) =>
        {weatherData(value.data), print('weatherdata: ${value.data}')});

    isLoading.value = false;
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
        position.latitude,
        position.longitude,
      ).then((List<Placemark> placemarks) async {
        Placemark place = placemarks[0];
        subLocality.value = place.locality ?? '';
        await fetchWeatherData();
        print(place);
      });
    } catch (e) {
      print('Error fetching location: $e');
    }
  }
}
