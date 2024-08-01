import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_app/domain/entities/weather.dart';
import 'package:test_app/domain/usecases/get_current_weather.dart';
import 'package:dartz/dartz.dart'; // Import for Either and Right

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  const testWeatherDetail = WeatherEntity(
    cityName: 'London',
    main: 'Clouds',
    description: 'Super cloudy',
    iconCode: '02d',
    temperature: 21.4,
    pressure: 1009,
    humidity: 85,
  );

  const testCityName = 'London';

  test(
    'should get current weather detail from the repository',
    () async {
      // arrange
      when(
        mockWeatherRepository.getCurrentWeather(testCityName),
      ).thenAnswer((_) async => const Right(testWeatherDetail));
      // act
      final result = await getCurrentWeatherUseCase.execute(testCityName);
      // assert
      expect(result, const Right(testWeatherDetail));
    },
  );
}