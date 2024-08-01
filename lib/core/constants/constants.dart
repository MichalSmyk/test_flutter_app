class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = '9b8f840c254a3aee8a2cb631af5aa52f';
  static String currentWeatherByName(String city) => 
    '$baseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) => 
    'http://openweathermap.org/img/wn/$iconCode@2x.png';
}