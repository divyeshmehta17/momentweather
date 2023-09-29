import 'package:dio/dio.dart';

import '../../../module/currentweather.dart';
import 'client.dart';
import 'endpoints.dart';

class APIManager {
  static Future<WeatherData> getWeatherData({
    required double latitude,
    required double longitude,
    required String cityName,
  }) async {
    try {
      final response =
          await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
              .get(Endpoints.forecast, queryParameters: {
        'current_weather': 'true',
        'latitude': latitude,
        'longitude': longitude,
        'daily': 'weathercode,temperature_2m_max,temperature_2m_min',
        'timezone': 'auto',
        'hourly': 'temperature_2m,windspeed_10m,precipitation,weathercode',
      });

      if (response.statusCode == 200) {
        final dynamic jsonData = response.data;

        // Check if jsonData is a list or a map
        if (jsonData is List) {
          // Handle the case where jsonData is a list (array) of data
          if (jsonData.isNotEmpty) {
            // Assuming you want to handle the first item in the list
            final weatherData = WeatherData.fromJson(jsonData[0]);
            return weatherData;
          } else {
            throw Exception('Empty JSON array received');
          }
        } else if (jsonData is Map<String, dynamic>) {
          // Handle the case where jsonData is a single JSON object
          final weatherData = WeatherData.fromJson(jsonData);
          return weatherData;
        } else {
          throw Exception('Invalid JSON format');
        }
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
