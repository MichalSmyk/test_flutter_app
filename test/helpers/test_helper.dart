import 'package:mockito/annotations.dart';
import 'package:test_app/data/data_sources/remote_data_source.dart';
import 'package:test_app/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/domain/usecases/get_current_weather.dart';


@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)

void main() {}