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
        'longitude': longitude,
        'daily': 'weathercode,temperature_2m_max,temperature_2m_min',
        'timezone': 'auto',
        'hourly': 'temperature_2m,windspeed_10m,precipitation,weathercode',
      });

//https://api.open-meteo.com/v1/forecast?latitude=21.194591&longitude=79.0640372&timezone=auto&current_weather=true
}
