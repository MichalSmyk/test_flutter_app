import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/data/models/weather_model.dart';
import 'package:test_app/domain/entities/weather.dart';

void main(){

const testWeatherModel = WeatherModel(
  cityName: 'London',
  main: 'Clouds',
  description: 'Super cloudy',
  iconCode: '02d',
  temperature: 21.4,
  pressure: 1009,
  humidity: 85,
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

    }
  );
}