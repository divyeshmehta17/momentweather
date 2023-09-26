class Endpoints {
  Endpoints._();
  static const int receiveTimeout = 15000;

// connectTimeout
  static const int connectionTimeout = 15000;
  static const String baseUrl = 'https://api.open-meteo.com/v1';

  static const String forecast = '/forecast';
}
