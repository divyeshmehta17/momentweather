import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:momentweatherapp/app/services/responsive_size.dart';

import '../../../../module/currentweather.dart';
import '../../../constants/image_constant.dart';
import '../../../services/text_style_util.dart';
import '../controllers/today_controller.dart';
import 'hourlyweather.dart';

class TodayView extends StatelessWidget {
  final TodayController controller = Get.put(TodayController());

  TodayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final weatherData = controller.weatherData.value;
        if (weatherData == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(top: 16.kh),
            child: Column(
              children: [
                _buildHeader(weatherData),
                _buildHourlyWeatherList(weatherData),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildHeader(WeatherData weatherData) {
    return Container(
      width: 361,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildCityContainer(controller.city.value),
                Padding(
                  padding: EdgeInsets.only(left: 175.kh, right: 3.kh),
                  child: SvgPicture.asset(ImageConstant.svgMoonwhite),
                ),
                Text(
                  'Clear',
                  style: TextStyleUtil.SFPro400(fontSize: 17),
                ),
              ],
            ),
            _buildTemperatureInfoRow(weatherData),
            _buildDivider(),
            _buildPrecipitationAndWindInfo(weatherData),
            _buildPrecipitationAndWindRow(weatherData),
          ],
        ),
      ),
    );
  }

  Widget _buildCityContainer(String city) {
    return Container(
      height: 22.kh,
      width: 65.kw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Center(
        child: Text(
          '$city',
          style: TextStyleUtil.SFPro400(fontSize: 17),
        ),
      ),
    );
  }

  Widget _buildHourlyWeatherList(WeatherData weatherData) {
    return Padding(
      padding: EdgeInsets.only(top: 18.kh),
      child: HourlyWeatherList(),
    );
  }

  Widget _buildTemperatureInfoRow(WeatherData weatherData) {
    return Padding(
      padding: EdgeInsets.only(top: 28.kh, bottom: 16.kh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${weatherData.currentWeather.temperature} °C',
            style: TextStyleUtil.SFPro400(fontSize: 50.kh),
          ),
          _buildTemperatureMinMaxColumn(weatherData),
        ],
      ),
    );
  }

  Widget _buildTemperatureMinMaxColumn(WeatherData weatherData) {
    return Padding(
      padding: EdgeInsets.only(right: 20.kh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildTemperatureIconRow(Icons.arrow_upward,
              weatherData.dailyWeather.temperature_2m_max[0].toString()),
          _buildTemperatureIconRow(Icons.arrow_downward,
              weatherData.dailyWeather.temperature_2m_min[0].toString()),
        ],
      ),
    );
  }

  Widget _buildTemperatureIconRow(IconData icon, String temperature) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          '$temperature °C',
          style: TextStyleUtil.SFPro400(fontSize: 15.kh),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1.kh,
      width: 305.kw,
      color: const Color(0xffebebf54d).withOpacity(0.3),
    );
  }

  Widget _buildPrecipitationAndWindInfo(WeatherData weatherData) {
    return Padding(
      padding: EdgeInsets.only(top: 20.kh),
      child: Row(
        children: [
          SvgPicture.asset(ImageConstant.svgdrop),
          Padding(
            padding: EdgeInsets.only(left: 4.0.kw, right: 175.kw),
            child: Text(
              '30%',
              style: TextStyleUtil.SFPro400(
                fontSize: 17,
                color: const Color.fromARGB(60, 235, 235, 245),
              ),
            ),
          ),
          SvgPicture.asset(ImageConstant.svgwave),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              "${weatherData.hourlyWeather.precipitation[0]} mm",
              style: TextStyleUtil.SFPro400(
                fontSize: 17,
                color: const Color.fromARGB(60, 235, 235, 245),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrecipitationAndWindRow(WeatherData weatherData) {
    return Row(
      children: [
        SvgPicture.asset(ImageConstant.svgwind),
        Padding(
          padding: EdgeInsets.only(left: 4.0.kw, right: 120.kw),
          child: Text(
            '${weatherData.currentWeather.windspeed} km/s',
            style: TextStyleUtil.SFPro400(
              fontSize: 17,
              color: const Color.fromARGB(60, 235, 235, 245),
            ),
          ),
        ),
        _buildDetailsButton(),
      ],
    );
  }

  Widget _buildDetailsButton() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextButton.icon(
        icon: const Icon(
          Icons.arrow_back,
          color: Color.fromARGB(60, 235, 235, 245),
        ),
        onPressed: () {},
        label: Text(
          'Details',
          style: TextStyleUtil.SFPro600(
            fontSize: 17,
            color: const Color.fromARGB(60, 235, 235, 245),
          ),
        ),
      ),
    );
  }
}
