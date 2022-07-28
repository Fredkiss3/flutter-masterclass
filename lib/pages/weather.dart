import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_app/components/weather_summary_card.dart';
import 'package:my_app/model/place.dart';
import 'package:weather/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();

    _fetchCurrentCityAndWeather();
  }

  final WeatherFactory _wf = WeatherFactory("43ad92100bd2d5934bbbcbe9302f120a",
      language: Language.FRENCH);

  Place? _currentPlace;
  bool _isLoading = false;

  void _fetchCurrentCityAndWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var position = await _determinePosition();
      var places = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      List<Weather> forecast = await _wf.fiveDayForecastByLocation(
          position.latitude, position.longitude);

      for (var f in forecast) {
        print(""""Current Weather: 
        Day: ${f.date}
        City Name: ${f.areaName}
        Country Code: ${f.country}
        temp: ${f.temperature?.celsius} """);
      }

      setState(() {
        _currentPlace =
            Place(countryCode: places[0].isoCountryCode, weather: forecast[0]);
      });
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () => _fetchCurrentCityAndWeather(),
                child: const Text("Refetch current city")),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : WeatherSummaryCard(place: _currentPlace!)),
          )
        ],
      ),
    ));
  }
}
