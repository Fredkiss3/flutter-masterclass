class WeatherForeCast {
  final String description;
  final double humidity;
  final double temperature;
  final double windSpeed;
  final double pressure;

  const WeatherForeCast({
    required this.pressure,
    required this.temperature,
    required this.windSpeed,
    required this.description,
    required this.humidity,
  });

  factory WeatherForeCast.fromMap(Map<String, dynamic> map) {
    return WeatherForeCast(
        pressure: map["pressure"],
        temperature: map["temperature"],
        windSpeed: map["windSpeed"],
        description: map["weather"][0]["description"],
        humidity: map["humidity"]);
  }
}
