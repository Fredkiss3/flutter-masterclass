import 'package:weather/weather.dart';

class Place {
  final String? countryCode;
  final Weather weather;

  Place({required this.weather, this.countryCode});

  String get city => weather.areaName ?? 'Unknown';
  String get cityAndCountry => weather.areaName == null
      ? 'Unknown'
      : "${weather.areaName}, $countryCode";
  double get long => weather.longitude!;
  double get pressure => weather.pressure!;
  double get windSpeed => weather.windSpeed!;
  double get humidity => weather.humidity!;
  String get description => weather.weatherDescription!;
  double get lat => weather.latitude!;
  double get temp => weather.temperature!.celsius!;
  String? get weatherDate {
    return """${weather.date!.day.toString().padLeft(2, '0')}/${weather.date!.month.toString().padLeft(2, '0')} ${weather.date!.hour.toString().padLeft(2, '0')}:${weather.date!.minute.toString().padLeft(2, '0')}""";
  }
}
