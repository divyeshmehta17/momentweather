import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:momentweatherapp/app/constants/image_constant.dart';
import 'package:momentweatherapp/app/services/responsive_size.dart';

import '../../../services/text_style_util.dart';
import '../controllers/near_controller.dart';

class HourlyweaterList extends StatefulWidget {
  const HourlyweaterList({super.key});

  @override
  State<HourlyweaterList> createState() => _HourlyweaterListState();
}

class _HourlyweaterListState extends State<HourlyweaterList> {
  @override
  Widget build(BuildContext context) {
    final NearController hourlyController = Get.put(NearController());

    // Calculate the current hour
    final DateTime currentTime = DateTime.now();
    final int currentHour = currentTime.hour;

    // Find the index that corresponds to the current hour
    int currentIndex = 0;
    if (hourlyController.hourlyData['hourly']['time'].isNotEmpty) {
      for (int i = 0;
          i < hourlyController.hourlyData['hourly']['time'].length;
          i++) {
        final datetimeString = hourlyController.hourlyData['hourly']['time'][i];
        final timeOnly = DateTime.parse(datetimeString).toLocal().toLocal();
        final hour = timeOnly.hour;
        if (hour >= currentHour) {
          currentIndex = i;
          break;
        }
      }
    }

    return Container(
      height: 220.kh,
      width: 494.kw,
      decoration: BoxDecoration(
        color: Color(0xff1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.kw, top: 24.kh, bottom: 16.kh),
            child: Text(
              'Hourly weather',
              style: TextStyleUtil.SFPro600(fontSize: 17),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  (hourlyController.hourlyData['hourly']['time'].length >=
                          currentIndex + 8)
                      ? currentIndex + 8
                      : hourlyController.hourlyData['hourly']['time'].length,
              padding: EdgeInsets.only(left: 24),
              itemBuilder: (context, index) {
                final int dataIndex = currentIndex + index;
                if (dataIndex >=
                    hourlyController.hourlyData['hourly']['time'].length) {
                  return SizedBox.shrink(); // Prevent out of index error
                }

                final datetimeString =
                    hourlyController.hourlyData['hourly']['time'][dataIndex];
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
                    color: Color(0xFF2C2C2E),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          timeString,
                          style: TextStyleUtil.SFPro400(fontSize: 14),
                        ),
                        SvgPicture.asset(iconAsset),
                        Text(
                          '${hourlyController.hourlyData['hourly']['temperature_2m'][dataIndex].toString()} °C',
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
}
