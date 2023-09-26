import 'package:dio/dio.dart';

import 'client.dart';
import 'endpoints.dart';

class APIManager {
  ///Post API
  static Future<Response> getcurrentweatherdata(
          {required String latitude, required String longitude}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.forecast, queryParameters: {
        'current_weather': 'true',
        'latitude': latitude,
        'longitude': longitude
      });

  static Future<Response> gethourlyweatherdata(
          {required String latitude, required String longitude}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.forecast, queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'hourly': 'temperature_2m,windspeed_10m,precipitation,weathercode',
      });

  static Future<Response> getfivedayweatherdata(
          {required String latitude, required String longitude}) async =>
      await DioClient(Dio(), showSnakbar: true, isOverlayLoader: true)
          .get(Endpoints.forecast, queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'daily': 'weathercode,temperature_2m_max,temperature_2m_min',
      });

//https://api.open-meteo.com/v1/forecast?latitude=21.194591&longitude=79.0640372&timezone=auto&current_weather=true
}
