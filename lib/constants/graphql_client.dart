import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final httpLink = HttpLink("https://beta.pokeapi.co/graphql/v1beta");

final ValueNotifier<GraphQLClient> graphQLClient = ValueNotifier(
    GraphQLClient(cache: GraphQLCache(store: InMemoryStore()), link: httpLink));

const getPokemonQuery = """
  query(\$name: String!) {
    pokemons: pokemon_v2_pokemon(where: {name: {_ilike: \$name}}, limit: 20) {
      name
      id
      sprites: pokemon_v2_pokemonsprites {
        json: sprites
      }
    }
  }
""";
