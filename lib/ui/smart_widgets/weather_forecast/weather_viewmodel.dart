import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/services/database_service.dart';
import 'package:parkparty/ui/smart_widgets/weather_forecast/weather_view.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart';

class WetterViewModel extends BaseViewModel {
  final DatabaseService _databaseService = locator<DatabaseService>();

  bool get wetterWidgetExists => _databaseService.wetterWidgetExists;
  Widget get wetterWidget => _databaseService.wetterWidget;

  Future<Widget> getWeather() async {
    Response _response = await get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/onecall?lat=52.2667&lon=10.5333&units=metric&exclude=alerts,minutely,daily&appid=7bf64a27fe66c2dc29f946acffe6dc77'),
    );
    if (_response.statusCode == 200) {
      double sum = 0;
      String data = _response.body;
      Map<String, dynamic> map = jsonDecode(data);
      double temperature = map['current']['temp'];
      String condition = map['current']['weather'][0]['main'];
      for (int i = 0; i <= 3; i++) {
        sum += map['hourly'][i]['pop'];
      }
      _databaseService.setWetter(
        getViewForCondition(
          condition,
          temperature.round(),
          ((sum / 4) * 100).round(),
        ),
      );
      return getViewForCondition(
        condition,
        temperature.round(),
        (sum / 4).round(),
      );
    } else {
      print(_response.statusCode);
      _databaseService.setWetter(Container());
      return Container();
    }
  }

  Widget getViewForCondition(String condition, int temp, int pop) {
    if (condition == "Clouds") {
      return WetterWolken(temp: temp, pop: pop);
    } else if (condition == "Clear") {
      return WetterSonne(temp: temp, pop: pop);
    } else {
      return WetterRegen(temp: temp, pop: pop);
    }
  }
}
