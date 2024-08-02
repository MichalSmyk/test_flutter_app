import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/domain/entities/weather.dart';
import 'package:test_app/presentation/block/weather_bloc.dart';
import 'package:test_app/presentation/block/weather_event.dart';
import 'package:test_app/presentation/block/weather_state.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main () {

  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp((){
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

  const testWeather = WeatherEntity(
    cityName: 'London',
    main: 'Clouds',
    description: 'scattered clouds',
    iconCode: '03d',
    temperature: 280.32,
    pressure: 1012,
    humidity: 81,
    );

    const testCityName = 'London';

    test('initial state should be empty', (){
      expect(weatherBloc.state, WeatherEmpty());
    }
  );

    blocTest<WeatherBloc,WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
    build: () {
      when(
        mockGetCurrentWeatherUseCase.execute(testCityName)
      ).thenAnswer((_) async => const Right(testWeather));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(testWeather)
    ]
  );

  
    blocTest<WeatherBloc,WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when get data is unsuccessful',
    build: () {
      when(
        mockGetCurrentWeatherUseCase.execute(testCityName)
      ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoadFailue('Server Failure')
    ]
  );
}