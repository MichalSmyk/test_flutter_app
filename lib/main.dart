import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/presentation/block/pages/weather_page.dart';
import 'package:test_app/presentation/block/weather_bloc.dart';


import 'presentation/bloc/weather_bloc.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<WeatherBloc>(),
        )
      ],
      child: const MaterialApp(
        home: WeatherPage(),
      ),
    );
  }
}