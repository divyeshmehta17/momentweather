class WeatherData {
  double latitude;
  double longitude;
  double generationTimeMs;
  int utcOffsetSeconds;
  String timezone;
  String timezoneAbbreviation;
  double elevation;
  CurrentWeather currentWeather;
  HourlyUnits hourlyUnits;
  List<String> hourlyTime;
  List<double> temperature2m;
  List<double> windSpeed10m;
  List<double> precipitation;
  List<int> weatherCode;
  DailyUnits dailyUnits;
  List<String> dailyTime;
  List<int> dailyWeatherCode;
  List<double> temperature2mMax;
  List<double> temperature2mMin;

  WeatherData({
    required this.latitude,
    required this.longitude,
    required this.generationTimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentWeather,
    required this.hourlyUnits,
    required this.hourlyTime,
    required this.temperature2m,
    required this.windSpeed10m,
    required this.precipitation,
    required this.weatherCode,
    required this.dailyUnits,
    required this.dailyTime,
    required this.dailyWeatherCode,
    required this.temperature2mMax,
    required this.temperature2mMin,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      latitude: json['latitude'],
      longitude: json['longitude'],
      generationTimeMs: json['generationtime_ms'],
      utcOffsetSeconds: json['utc_offset_seconds'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      elevation: json['elevation'],
      currentWeather: CurrentWeather.fromJson(json['current_weather']),
      hourlyUnits: HourlyUnits.fromJson(json['hourly_units']),
      hourlyTime: List<String>.from(json['hourly']['time']),
      temperature2m: List<double>.from(json['hourly']['temperature_2m']),
      windSpeed10m: List<double>.from(json['hourly']['windspeed_10m']),
      precipitation: List<double>.from(json['hourly']['precipitation']),
      weatherCode: List<int>.from(json['hourly']['weathercode']),
      dailyUnits: DailyUnits.fromJson(json['daily_units']),
      dailyTime: List<String>.from(json['daily']['time']),
      dailyWeatherCode: List<int>.from(json['daily']['weathercode']),
      temperature2mMax: List<double>.from(json['daily']['temperature_2m_max']),
      temperature2mMin: List<double>.from(json['daily']['temperature_2m_min']),
    );
  }
}

class CurrentWeather {
  double temperature;
  double windSpeed;
  int windDirection;
  int weatherCode;
  int isDay;
  String time;

  CurrentWeather({
    required this.temperature,
    required this.windSpeed,
    required this.windDirection,
    required this.weatherCode,
    required this.isDay,
    required this.time,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: json['temperature'],
      windSpeed: json['windspeed'],
      windDirection: json['winddirection'],
      weatherCode: json['weathercode'],
      isDay: json['is_day'],
      time: json['time'],
    );
  }
}

class HourlyUnits {
  String time;
  String temperature2m;
  String windSpeed10m;
  String precipitation;
  String weatherCode;

  HourlyUnits({
    required this.time,
    required this.temperature2m,
    required this.windSpeed10m,
    required this.precipitation,
    required this.weatherCode,
  });

  factory HourlyUnits.fromJson(Map<String, dynamic> json) {
    return HourlyUnits(
      time: json['time'],
      temperature2m: json['temperature_2m'],
      windSpeed10m: json['windspeed_10m'],
      precipitation: json['precipitation'],
      weatherCode: json['weathercode'],
    );
  }
}

class DailyUnits {
  String time;
  String weatherCode;
  String temperature2mMax;
  String temperature2mMin;

  DailyUnits({
    required this.time,
    required this.weatherCode,
    required this.temperature2mMax,
    required this.temperature2mMin,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) {
    return DailyUnits(
      time: json['time'],
      weatherCode: json['weathercode'],
      temperature2mMax: json['temperature_2m_max'],
      temperature2mMin: json['temperature_2m_min'],
    );
  }
}
