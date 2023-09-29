import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:momentweatherapp/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/text_style_util.dart';
import '../../today/controllers/today_controller.dart';

class FivedaysView extends GetView<TodayController> {
  FivedaysView({Key? key}) : super(key: key);

  Widget buildWeatherItem(int index) {
    final weatherData = controller.weatherData.value;
    final currentTime = DateTime.now();
    final itemTimeString = weatherData?.dailyWeather.time[index];
    final itemTime =
        DateTime.parse(itemTimeString); // Parse the string to DateTime
    final isToday = currentTime.year == itemTime.year &&
        currentTime.month == itemTime.month &&
        currentTime.day == itemTime.day;
    final timeText = isToday ? 'Today' : DateFormat('d MMM').format(itemTime);

    return Container(
      height: 126.kh,
      width: 361.kw,
      margin: EdgeInsets.only(bottom: 16.kh),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF1C1C1E),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.kh, bottom: 17.kh),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.kh),
                  child: Container(
                    height: 24.kh,
                    width: 80.kw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${controller.city.value}',
                        style: TextStyleUtil.SFPro400(fontSize: 17),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 70.kw),
                  child: Text(
                    timeText,
                    style: TextStyleUtil.SFPro400(fontSize: 17),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50.kw),
                  child: SvgPicture.asset(ImageConstant.svgMoonwhite),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    'Clear',
                    style: TextStyleUtil.SFPro400(fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.kw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16.kw),
                  child: Text(
                    ' ${weatherData?.dailyWeather.temperature_2m_max[index]}°C',
                    style: TextStyleUtil.SFPro400(
                      fontSize: 40.kh,
                      color: const Color.fromARGB(60, 235, 235, 245),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.kw, left: 10),
                  child: Container(
                    height: 40.kh,
                    width: 1.kw,
                    color: const Color(0xffebebf54d).withOpacity(0.3),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.kw, right: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(ImageConstant.svgdrop),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              '%',
                              style: TextStyleUtil.SFPro400(
                                fontSize: 13,
                                color: const Color.fromARGB(60, 235, 235, 245),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 45.0, right: 3),
                            child: SvgPicture.asset(ImageConstant.svgwave),
                          ),
                          Text(
                            //precipitation
                            'mm',
                            style: TextStyleUtil.SFPro400(
                              fontSize: 13,
                              color: const Color.fromARGB(60, 235, 235, 245),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10.kw, right: 12.kw, top: 12.kh),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(ImageConstant.svgwind),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 4.0.kw, right: 12.kw),
                            child: Text(
                              'm/s',
                              style: TextStyleUtil.SFPro400(
                                fontSize: 13,
                                //temperature_2m
                                color: const Color.fromARGB(60, 235, 235, 245),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.kw, top: 24.kh, bottom: 16.kh),
          child: Text(
            'Hourly weather',
            style: TextStyleUtil.SFPro600(fontSize: 17),
          ),
        ),
        Obx(() {
          final weatherData = controller.weatherData.value;
          if (weatherData == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return buildWeatherItem(index);
                },
              ),
            );
          }
        }),
      ],
    );
  }
}
