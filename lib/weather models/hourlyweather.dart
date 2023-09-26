class HourlyWeather {
  final List<String> time;
  final List<double> temperature2m;
  final List<double> windSpeed10m;
  final List<double> precipitation;
  final List<int> weatherCode;

  HourlyWeather({
    required this.time,
    required this.temperature2m,
    required this.windSpeed10m,
    required this.precipitation,
    required this.weatherCode,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: List<String>.from(json['time']),
      temperature2m: List<double>.from(json['temperature_2m']),
      windSpeed10m: List<double>.from(json['windspeed_10m']),
      precipitation: List<double>.from(json['precipitation']),
      weatherCode: List<int>.from(json['weathercode']),
    );
  }
}
