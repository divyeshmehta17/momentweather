import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:momentweatherapp/app/services/responsive_size.dart';

import '../../../services/text_style_util.dart';
import '../controllers/today_controller.dart';

class HourlyWeatherList extends StatelessWidget {
  const HourlyWeatherList({super.key});

  @override
  Widget build(BuildContext context) {
    final TodayController controller = Get.put(TodayController());
    return Obx(
      () {
        final weatherData = controller.weatherData.value;
        final currentTime = DateTime.now();
        final next24Hours = currentTime.add(Duration(hours: 24));

        return Container(
          height: 220.kh,
          width: 494.kw,
          decoration: BoxDecoration(
            color: const Color(0xff1C1C1E),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 24.kw, top: 24.kh, bottom: 16.kh),
                child: Text(
                  'Hourly weather',
                  style: TextStyleUtil.SFPro600(fontSize: 17),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: weatherData?.hourlyWeather.time.length,
                  padding: const EdgeInsets.only(left: 24),
                  itemBuilder: (context, index) {
                    final hourlyTime =
                        DateTime.parse(weatherData?.hourlyWeather.time[index]);

                    if (hourlyTime.isAfter(currentTime) &&
                        hourlyTime.isBefore(next24Hours)) {
                      final String iconAsset = hourlyTime.hour >= 6 &&
                              hourlyTime.hour < 12
                          ? 'assets/images/sunrise.svg'
                          : hourlyTime.hour >= 12 && hourlyTime.hour < 18
                              ? 'assets/images/fullsun.svg'
                              : hourlyTime.hour >= 18 && hourlyTime.hour < 21
                                  ? 'assets/images/Moon.svg'
                                  : 'assets/images/cloudmoon.svg';

                      return WeatherCard(
                        time: '${hourlyTime.hour}:00',
                        iconAsset: iconAsset,
                        temperature: weatherData!
                            .hourlyWeather.temperature_2m[index]
                            .toString(),
                      );
                    } else {
                      return SizedBox
                          .shrink(); // Use SizedBox.shrink() for an empty container.
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class WeatherCard extends StatelessWidget {
  final String time;
  final String iconAsset;
  final String temperature;

  WeatherCard({
    required this.time,
    required this.iconAsset,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116.kh,
      width: 84.kw,
      margin: EdgeInsets.only(right: 12.kw, bottom: 12.kh),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Card(
        color: const Color(0xFF2C2C2E),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              time,
              style: TextStyleUtil.SFPro400(fontSize: 14),
            ),
            SvgPicture.asset(iconAsset),
            Text(
              '$temperature °C',
              style: TextStyleUtil.SFPro400(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
