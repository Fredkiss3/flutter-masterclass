import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_app/components/pokemon_card.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/model/pokemon.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../constants/graphql_client.dart';

class PokedexSearchScreen extends StatefulWidget {
  const PokedexSearchScreen({Key? key}) : super(key: key);

  @override
  State<PokedexSearchScreen> createState() => _PokedexSearchScreenState();
}

class _PokedexSearchScreenState extends State<PokedexSearchScreen> {
  String _query = "";
  final _queryController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _queryController.addListener(() => setState(() {
          print("Updating Query : $_query");
          _query = _queryController.text;
        }));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _queryController.dispose();
    super.dispose();
  }

  void searchPokemons() {}

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(getPokemonQuery),
        variables: {
          'name': "$_query%",
        },
      ),
      builder: ((result, {fetchMore, refetch}) {
        List pokemonsFromAPI = result.data?['pokemons'] ?? [];
        List<Pokemon> pokemons = [];
        if (pokemonsFromAPI.isNotEmpty) {
          pokemons.addAll(pokemonsFromAPI.map((e) => Pokemon.fromMap(e)));
        }
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pokédex',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Recherchez un pokémon en fonction de son nom.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: secondaryColor.withAlpha(60)),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: textColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _queryController,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Nom du pokémon',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: textColor.withAlpha(100)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 60,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: secondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            onPressed: () {},
                            child: const Icon(
                              CupertinoIcons.chart_bar_alt_fill,
                              size: 32,
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: result.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: secondaryColor,
                              ),
                            )
                          : GridView.count(
                              childAspectRatio: (9 / 12),
                              crossAxisCount: 2,
                              crossAxisSpacing: 20.0,
                              shrinkWrap: true,
                              mainAxisSpacing: 20.0,
                              children: pokemons
                                  .map((p) => PokemonCard(pokemon: p))
                                  .toList(),
                            ))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
