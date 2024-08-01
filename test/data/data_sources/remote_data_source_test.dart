import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_app/core/constants/constants.dart';
import 'package:test_app/core/error/exception.dart';

import 'package:test_app/data/data_sources/remote_data_source.dart';
import 'package:test_app/data/models/weather_model.dart';
import 'package:http/http.dart' as http;
import '../../helpers/dummy_data/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {

  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;


setUp(() {
  mockHttpClient = MockHttpClient();
  weatherRemoteDataSourceImpl = WeatherRemoteDataSourceImpl(client: mockHttpClient);
});

const testCityName = 'Zocca';

group('get current weather', (){
    test('should return weather model when the response code is 200', () async {
      
      //arrange
      when(
        mockHttpClient.get(
          Uri.parse(Urls.currentWeatherByName(testCityName))
        )
      ).thenAnswer(
        (_) async => http.Response(
          readJson('helpers/dummy_data/dummy_weather_response.json'),
          200
        )
      );

      //act
      final result = await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      //assert
      expect(result, isA<WeatherModel>());

    });

        test('should throw a server exception whenthe response code is 404 or other', () async {
      
      //arrange
      when(
        mockHttpClient.get(
          Uri.parse(Urls.currentWeatherByName(testCityName))
        )
      ).thenAnswer(
        (_) async => http.Response(
          'Not found',
          404
        )
      );

      //act
      final result = weatherRemoteDataSourceImpl.getCurrentWeather;

      //assert
      expectLater(result(testCityName), throwsA(isA<ServerException>()));

    });
});

}