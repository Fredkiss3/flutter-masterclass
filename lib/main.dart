import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/constants/graphql_client.dart';
import 'package:my_app/pages/create_question.dart';
import 'package:my_app/pages/pokedex.dart';
import 'package:my_app/pages/quizz.dart';
import 'package:my_app/pages/competences.dart';
import 'package:my_app/pages/home.dart';
import 'package:my_app/pages/weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: graphQLClient,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
              primary: primaryColor,
              tertiary: tertiaryColor,
              secondary: secondaryColor,
              background: bgColor),

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            headline1: TextStyle(
                // fontFamily: 'Caros',
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                height: 1,
                color: textColor),
            headline2: TextStyle(
                // fontFamily: 'Caros',
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
                height: 1,
                color: textColor),
            headline3: TextStyle(
                // fontFamily: 'Caros',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                height: 1,
                color: textColor),
            headline6: TextStyle(
                // fontFamily: 'Caros',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                height: 1,
                color: textColor),
            bodyText1: TextStyle(
                // fontFamily: 'Caros',
                fontSize: 14.0,
                height: 1,
                fontWeight: FontWeight.w400,
                color: textColor),
            button: TextStyle(
                // fontFamily: 'Caros',
                fontSize: 14.0,
                height: 1,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
        ),
        title: 'Flutter Demo',
        routes: {
          '/': (context) => const WeatherScreen(),
          '/pokedex': (context) => const PokedexSearchScreen(),
          '/quizz': (context) => const QuizzAppScreen(),
          '/create-question': (context) => const CreateQuestionScreen(),
          '/profil': (context) => const HomeScreen(),
          '/competences': (context) => const CompetenceScreen(),
        },
      ),
    );
  }
}
