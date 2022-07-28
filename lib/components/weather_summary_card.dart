import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/model/place.dart';

class WeatherSummaryCard extends StatelessWidget {
  final Place place;
  const WeatherSummaryCard({Key? key, required this.place}) : super(key: key);

  Map<String, Color> getColorForTemperature(int temp) {
    if (temp < 30) {
      return {
        "fg": textColor,
        "bg": clearSkyColor,
      };
    } else if (temp >= 30 && temp < 40) {
      return {
        "fg": textColor,
        "bg": tertiaryColor,
      };
    } else {
      return {"bg": dangerColor, "fg": bgColor};
    }
  }

  @override
  Widget build(BuildContext context) {
    var colors = getColorForTemperature(place.temp.ceil());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: colors['bg']),
      child: Column(
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.placemark, color: colors['fg']),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                place.cityAndCountry,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: colors['fg']),
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                place.weatherDate ?? 'No date',
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.w300, color: colors['fg']),
              ))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "${place.temp.ceil().toString()}°",
              style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontSize: 100,
                  fontWeight: FontWeight.w500,
                  color: colors['fg']),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            place.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                fontWeight: FontWeight.w400, fontSize: 24, color: colors['fg']),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(CupertinoIcons.gauge, color: colors['fg']),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${place.windSpeed.ceil().toString()} hpa",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.w400, color: colors['fg']),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(CupertinoIcons.drop, color: colors['fg']),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${place.humidity.ceil().toString()} %",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.w400, color: colors['fg']),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(CupertinoIcons.wind, color: colors['fg']),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${place.windSpeed.ceil().toString()} km/h",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.w400, color: colors['fg']),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
