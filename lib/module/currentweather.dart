class WeatherData {
  final double latitude;
  final double longitude;
  final double elevation;
  final double temperature;
  final CurrentWeather currentWeather;
  final DailyWeather dailyWeather;
  final HourlyWeather hourlyWeather;

  WeatherData(
      {required this.temperature,
      required this.latitude,
      required this.longitude,
      required this.elevation,
      required this.currentWeather,
      required this.dailyWeather,
      required this.hourlyWeather});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final currentWeather = json['current_weather'];
    final dailyWeather = json['daily'];
    final hourlyWeather = json['hourly'];
    // Check if "current_weather" is null or doesn't contain "time"
    if (currentWeather == null || !currentWeather.containsKey('time')) {
      throw FormatException(
          'Invalid JSON: "current_weather" or "time" is missing.');
    }

    return WeatherData(
      latitude: json['latitude'],
      longitude: json['longitude'],
      elevation: json['elevation'].toDouble(),
      temperature: json['current_weather']['temperature'].toDouble(),
      currentWeather: CurrentWeather.fromJson(currentWeather),
      dailyWeather: DailyWeather.fromJson(dailyWeather),
      hourlyWeather: HourlyWeather.fromJson(hourlyWeather),
    );
  }
}

class CurrentWeather {
  final double temperature;
  final double windspeed;
  final int winddirection;
  final int weathercode;
  final int isDay;
  final String time;

  CurrentWeather({
    required this.temperature,
    required this.windspeed,
    required this.winddirection,
    required this.weathercode,
    required this.isDay,
    required this.time,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: json['temperature'],
      windspeed: json['windspeed'],
      winddirection: json['winddirection'],
      weathercode: json['weathercode'],
      isDay: json['is_day'],
      time: json['time'],
    );
  }
}

class DailyWeather {
  final List temperature_2m_max;
  final List temperature_2m_min;
  final List weathercode;
  final List time;

  DailyWeather({
    required this.temperature_2m_max,
    required this.temperature_2m_min,
    required this.weathercode,
    required this.time,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      temperature_2m_max: json['temperature_2m_max'],
      temperature_2m_min: json['temperature_2m_min'],
      weathercode: json['weathercode'],
      time: json['time'],
    );
  }
}

class HourlyWeather {
  final List temperature_2m;
  final List windspeed_10m;
  final List precipitation;
  final List weathercode;
  final List time;

  HourlyWeather({
    required this.temperature_2m,
    required this.windspeed_10m,
    required this.precipitation,
    required this.weathercode,
    required this.time,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      temperature_2m: json['temperature_2m'],
      windspeed_10m: json['windspeed_10m'],
      precipitation: json['precipitation'],
      weathercode: json['weathercode'],
      time: json['time'],
    );
  }
}
