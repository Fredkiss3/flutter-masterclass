import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Hello world, je suis Adrien KISSIE',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                  text: 'Développeur web et streamer sur ',
                  style: Theme.of(context).textTheme.bodyText1,
                  children: [
                    TextSpan(
                        text: 'twitch',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        )),
                    const TextSpan(
                      text:
                          ', je crée des applications web orientées performance du backend au frontend.',
                    ),
                  ]),
            ),
            Expanded(flex: 1, child: Image.asset('./assets/adrien.png')),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                        onPressed: () =>
                            {Navigator.of(context).pushNamed('/competences')},
                        child: const Text(
                          'Mes compétences',
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                        onPressed: () =>
                            {Navigator.of(context).pushNamed('/competences')},
                        child: const Text(
                          'Mon entreprise',
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                        onPressed: () =>
                            {Navigator.of(context).pushNamed('/competences')},
                        child: const Text(
                          'Contactez-moi',
                        )),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
