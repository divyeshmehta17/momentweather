import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:momentweatherapp/app/constants/image_constant.dart';
import 'package:momentweatherapp/app/services/responsive_size.dart';

import '../../../services/text_style_util.dart';
import '../controllers/near_controller.dart';

class HourlyWeatherList extends StatelessWidget {
  const HourlyWeatherList({Key? key});

  @override
  Widget build(BuildContext context) {
    final NearController controller = Get.put(NearController());

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        final Map<dynamic, dynamic>? weatherData = controller.weatherData.value;

        if (weatherData == null || weatherData['hourly'] == null) {
          // Handle the case where weatherData or 'hourly' is null
          return Text('No weather data available');
        }

        final DateTime currentTime = DateTime.now();
        final int currentHour = currentTime.hour;

        final currentIndex =
            weatherData['hourly']!['time'].indexWhere((datetimeString) {
          final timeOnly = DateTime.parse(datetimeString).toLocal().toLocal();
          final hour = timeOnly.hour;
          return hour >= currentHour;
        });

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
                  itemCount: (weatherData['hourly']!['time'].length >=
                          currentIndex + 8)
                      ? currentIndex + 8
                      : weatherData['hourly']!['time'].length,
                  padding: const EdgeInsets.only(left: 24),
                  itemBuilder: (context, index) {
                    final int dataIndex = currentIndex + index;
                    if (dataIndex >= weatherData['hourly']!['time'].length) {
                      return const SizedBox
                          .shrink(); // Prevent out of index error
                    }

                    final datetimeString =
                        weatherData['hourly']!['time'][dataIndex];
                    final timeOnly =
                        DateTime.parse(datetimeString).toLocal().toLocal();
                    final timeString = '${timeOnly.hour}:${timeOnly.minute}';
                    String iconAsset;
                    if (timeOnly.hour >= 6 && timeOnly.hour < 12) {
                      // Morning (6 AM - 11:59 AM)
                      iconAsset = ImageConstant.svgsunrise;
                    } else if (timeOnly.hour >= 12 && timeOnly.hour < 18) {
                      // Afternoon (12 PM - 5:59 PM)
                      iconAsset = ImageConstant.svgfullsun;
                    } else if (timeOnly.hour >= 18 && timeOnly.hour < 21) {
                      // Evening (6 PM - 8:59 PM)
                      iconAsset = ImageConstant.svgcloudmoon;
                    } else {
                      // Night (9 PM - 5:59 AM)
                      iconAsset = ImageConstant.svgMoon;
                    }

                    return Container(
                      height: 116.kh,
                      width: 84.kw,
                      margin: EdgeInsets.only(right: 12.kw, bottom: 12.kh),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Card(
                        color: const Color(0xFF2C2C2E),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              timeString,
                              style: TextStyleUtil.SFPro400(fontSize: 14),
                            ),
                            SvgPicture.asset(iconAsset),
                            Text(
                              '${weatherData['hourly']!['temperature_2m'][dataIndex].toString()} °C',
                              style: TextStyleUtil.SFPro400(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
