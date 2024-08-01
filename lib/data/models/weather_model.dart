import 'package:test_app/domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required String cityName,
    required String main,
    required String description,
    required String iconCode,
    required double temperature,
    required int pressure,
    required int humidity,
  }) : super(
    cityName: cityName,
    main: main,
    description: description,
    iconCode: iconCode,
    temperature: temperature,
    pressure: pressure,
    humidity: humidity,
  );
}