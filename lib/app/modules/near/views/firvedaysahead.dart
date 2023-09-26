import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:momentweatherapp/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/text_style_util.dart';
import '../controllers/near_controller.dart';

class FiveDaysAhead extends GetView<NearController> {
  const FiveDaysAhead({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final NearController controller = Get.put(NearController());
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
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              String dateString =
                  controller.fivedaysData['daily']['time'][index].toString();

              String todayDate = DateTime.now().toString().substring(0, 10);

              // Check if the date is today's date
              bool isToday = dateString == todayDate;

              // Format the date string with the month name
              DateTime date = DateTime.parse(dateString);
              String formattedDate = isToday
                  ? 'Today'
                  : DateFormat('MMM d')
                      .format(date); // Format the date with month name
              int selectedIndex = 0;
              final isSelected = index == selectedIndex;
              return Container(
                height: 126.kh,
                width: 361.kw,
                margin: EdgeInsets.only(bottom: 16.kh),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            Color(0xFF062D66),
                            Color(0xFF0B2C6C),
                            Color(0xFF04245D),
                            Color(0xFF123F5F),
                            Color(0xFF316477),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      : null, // Set to null for no gradient
                  borderRadius: BorderRadius.circular(24),
                  color: isSelected
                      ? null
                      : Color(
                          0xFF1C1C1E), // Set color to black for non-selected items
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
                                  '${controller.subLocality}',
                                  style: TextStyleUtil.SFPro400(fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 70.kw),
                            child: Text(
                              formattedDate,
                              style: TextStyleUtil.SFPro400(fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 50.kw),
                            child: SvgPicture.asset(ImageConstant.svgMoonwhite),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.0),
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
                              '${controller.fivedaysData['daily']['temperature_2m_max'][index].toString()} °C',
                              style: TextStyleUtil.SFPro400(
                                fontSize: 40.kh,
                                color: Color.fromARGB(60, 235, 235, 245),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.kw, left: 10),
                            child: Container(
                              height: 40.kh,
                              width: 1.kw,
                              color: Color(0xffEBEBF54D).withOpacity(0.3),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.kw, right: 10),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(ImageConstant.svgdrop),
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        '30%',
                                        style: TextStyleUtil.SFPro400(
                                          fontSize: 13,
                                          color:
                                              Color.fromARGB(60, 235, 235, 245),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 45.0, right: 3),
                                      child: SvgPicture.asset(
                                          ImageConstant.svgwave),
                                    ),
                                    Text(
                                      //precipitation
                                      '${controller.hourlyData['hourly']['precipitation'][0]} mm',
                                      style: TextStyleUtil.SFPro400(
                                        fontSize: 13,
                                        color:
                                            Color.fromARGB(60, 235, 235, 245),
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
                                      padding: EdgeInsets.only(
                                          left: 4.0.kw, right: 12.kw),
                                      child: Text(
                                        '${controller.weatherData['current_weather']['windspeed']} m/s',
                                        style: TextStyleUtil.SFPro400(
                                          fontSize: 13,
                                          //temperature_2m
                                          color:
                                              Color.fromARGB(60, 235, 235, 245),
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
            },
          ),
        ),
      ],
    );
  }
}
