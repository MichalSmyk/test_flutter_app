import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_app/core/error/exception.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/data/models/weather_model.dart';
import 'package:test_app/data/repositories/weather_repository_impl.dart';
import 'package:test_app/domain/entities/weather.dart';

import '../../helpers/dummy_data/test_helper.mocks.dart';

void main () {

  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;


  setUp((){
        mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'Zocca',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01d',
    temperature: 301.76,
    pressure: 1011,
    humidity: 35,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'Zocca',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01d',
    temperature: 301.76,
    pressure: 1011,
    humidity: 35,
  );


  group('get current weather', (){
    test('should return weather entity when the response code is 200', () async {
      
      //arrange
      when(
        mockWeatherRemoteDataSource.getCurrentWeather('Zocca')
      ).thenAnswer(
        (_) async => testWeatherModel
      );

      //act
      final result = await weatherRepositoryImpl.getCurrentWeather('Zocca');

      //assert
      expect(result, equals(const Right(testWeatherEntity)));

    });

    test('should return a server failure when the response code is 404 or other', () async {
      
      //arrange
      when(
        mockWeatherRemoteDataSource.getCurrentWeather('Zocca')
      ).thenThrow(ServerException());

      //act
      final result = await weatherRepositoryImpl.getCurrentWeather('Zocca');

      //assert
      expect(result, equals(const Left(ServerFailure('An error has occurred'))));

    });
  });
}