import 'package:rxdart/rxdart.dart';
import 'package:test_app/domain/usecases/get_current_weather.dart';
import 'package:test_app/presentation/block/weather_event.dart';
import 'package:test_app/presentation/block/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent,WeatherState> {
  
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {

        emit(WeatherLoading());
        final result = await _getCurrentWeatherUseCase.execute(event.cityName);
        result.fold(
          (failure) {
            emit(WeatherLoadFailue(failure.message));
          },
          (data) {
            emit(WeatherLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }