import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:momentweatherapp/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/text_style_util.dart';
import '../controllers/near_controller.dart';
import 'hourlyweatherlist.dart';

class TodayView extends StatelessWidget {
  final NearController controller = Get.put(NearController());

  TodayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final Map weatherData = controller.weatherData.value;
        if (weatherData == null ||
            weatherData['current_weather'] == null ||
            weatherData['hourly'] == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: EdgeInsets.only(top: 16.kh),
          child: Column(
            children: [
              Container(
                  // Replace with your desired height
                  width: 361, // Replace with your desired width
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF062D66),
                        Color(0xFF0B2C6C),
                        Color(0xFF04245D),
                        Color(0xFF123F5F),
                        Color(0xFF316477),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.kh, top: 20.kh),
                    child: Obx(() {
                      final Map weatherData = controller.weatherData.value;

                      if (weatherData == null ||
                          weatherData['current_weather'] == null ||
                          weatherData['hourly'] == null) {
                        // Show a loader or a placeholder when data is being fetched or not available
                        return Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 22.kh,
                                width: 65.kw,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                                child: Center(
                                  child: Text(
                                    '${controller.subLocality.value}',
                                    style: TextStyleUtil.SFPro400(fontSize: 17),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 175.kh, right: 3.kh),
                                child: SvgPicture.asset(
                                    ImageConstant.svgMoonwhite),
                              ),
                              Text(
                                'Clear',
                                style: TextStyleUtil.SFPro400(fontSize: 17),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 28.kh, bottom: 16.kh),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${controller.weatherData['current_weather']['temperature']} °C',
                                  style:
                                      TextStyleUtil.SFPro400(fontSize: 50.kh),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 20.kh,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.arrow_upward,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            '${controller.weatherData['daily']['temperature_2m_max'][0]} °C',
                                            style: TextStyleUtil.SFPro400(
                                                fontSize: 15.kh),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 32.kh),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.arrow_downward,
                                                color: Colors.white),
                                            Text(
                                              '${controller.weatherData['daily']['temperature_2m_min'][0]} °C',
                                              style: TextStyleUtil.SFPro400(
                                                  fontSize: 15.kh),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 1.kh,
                            width: 305.kw,
                            color: const Color(0xffebebf54d).withOpacity(0.3),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.kh),
                            child: Row(
                              children: [
                                SvgPicture.asset(ImageConstant.svgdrop),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 4.0.kw, right: 175.kw),
                                  child: Text(
                                    '30%',
                                    style: TextStyleUtil.SFPro400(
                                        fontSize: 17,
                                        color: const Color.fromARGB(
                                          60,
                                          235,
                                          235,
                                          245,
                                        )),
                                  ),
                                ),
                                SvgPicture.asset(ImageConstant.svgwave),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    controller.weatherData['hourly'] != null
                                        ? '${controller.weatherData['hourly']['precipitation'][0]} mm'
                                        : 'N/A',
                                    style: TextStyleUtil.SFPro400(
                                        fontSize: 17,
                                        color: const Color.fromARGB(
                                          60,
                                          235,
                                          235,
                                          245,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(ImageConstant.svgwind),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 4.0.kw, right: 130.kw),
                                child: Text(
                                  '${controller.weatherData['current_weather']['windspeed']} m/s',
                                  style: TextStyleUtil.SFPro400(
                                      fontSize: 17,
                                      color: const Color.fromARGB(
                                        60,
                                        235,
                                        235,
                                        245,
                                      )),
                                ),
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextButton.icon(
                                  icon: const Icon(Icons.arrow_back,
                                      color: Color.fromARGB(
                                        60,
                                        235,
                                        235,
                                        245,
                                      )),
                                  onPressed: () {},
                                  label: Text(
                                    'Details',
                                    style: TextStyleUtil.SFPro600(
                                        fontSize: 17,
                                        color: const Color.fromARGB(
                                          60,
                                          235,
                                          235,
                                          245,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 18.kh),
                child: HourlyWeatherList(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
