import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/data/models/weather_model.dart';
import 'package:test_app/domain/entities/weather.dart';
import 'dart:convert';

import '../../helpers/dummy_data/json_reader.dart';

void main(){

const testWeatherModel = WeatherModel(
  cityName: 'Zocca',
  main: 'Clear',
  description: 'clear sky',
  iconCode: '01d',
  temperature: 301.76,
  pressure: 1011,
  humidity: 35,
);

  test(
    'should be a subclass of weather entity',
    () async {
      // assert
      expect(testWeatherModel, isA<WeatherEntity>());
    }
  );

  test('should return a valid model from json', 
    () async {
      //arrange
      final Map< String, dynamic > jsonMap = json.decode(
        readJson('helpers/dummy_data/dummy_weather_response.json'
        ),
      );
      //act
      final result = WeatherModel.fromJson(jsonMap);
      //assert

      expect(result, equals(testWeatherModel));
    }
  );
}