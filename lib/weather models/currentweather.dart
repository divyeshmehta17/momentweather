import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class CurrentWeather {
  final double latitude;
  final double longitude;
  final double generationTimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final WeatherInfo currentWeather;

  CurrentWeather({
    required this.latitude,
    required this.longitude,
    required this.generationTimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentWeather,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      latitude: json['latitude'],
      longitude: json['longitude'],
      generationTimeMs: json['generationtime_ms'],
      utcOffsetSeconds: json['utc_offset_seconds'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      elevation: json['elevation'],
      currentWeather: WeatherInfo.fromJson(json['current_weather']),
    );
  }

  static Future<CurrentWeather> fetchCurrentWeatherWithLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final Response response = await APIManager.getcurrentweatherdata(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> weatherData = response.data;

        final currentWeather = CurrentWeather.fromJson({
          'latitude': position.latitude,
          'longitude': position.longitude,
          'generationtime_ms': 0.0,
          'utc_offset_seconds': 0,
          'timezone': '',
          'timezone_abbreviation': '',
          'elevation': 0.0,
          'current_weather': weatherData,
        });

        return currentWeather;
      } else {
        throw Exception('Failed to fetch weather data');
      }
    } catch (e) {
      throw Exception('Error fetching location and weather data: $e');
    }
  }
}

class WeatherInfo {
  final double temperature;
  final double windSpeed;
  final int windDirection;
  final int weatherCode;
  final int isDay;
  final String time;

  WeatherInfo({
    required this.temperature,
    required this.windSpeed,
    required this.windDirection,
    required this.weatherCode,
    required this.isDay,
    required this.time,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      temperature: json['temperature'],
      windSpeed: json['windspeed'],
      windDirection: json['winddirection'],
      weatherCode: json['weathercode'],
      isDay: json['is_day'],
      time: json['time'],
    );
  }
}

// Replace with your actual APIManager and Dio configuration
class APIManager {
  static Dio dio = Dio(); // Initialize Dio instance with your configurations

  static Future<Response> getcurrentweatherdata({
    required String latitude,
    required String longitude,
  }) async {
    try {
      final response = await dio.get(
        'https://api.open-meteo.com/v1/forecast?latitude=21.194591&longitude=79.0640372&timezone=auto&current_weather=true',
      );
      return response;
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}
