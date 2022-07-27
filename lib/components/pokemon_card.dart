import 'package:flutter/material.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/model/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCard({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: secondaryColor.withAlpha(60)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Image.network(
                  pokemon.pngURL,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.warning,
                    color: dangerColor,
                  ),
                  loadingBuilder: (context, widget, loadingProgress) =>
                      Container(
                    padding: const EdgeInsets.all(1.0),
                    child: loadingProgress == null
                        ? widget
                        : const Expanded(
                            child: Center(child: CircularProgressIndicator())),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                pokemon.name,
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                pokemon.id.toString().padLeft(3, '0'),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
