import 'package:flutter/material.dart';

import '../services/service_api.dart';
import 'entities/pokemon.dart';

class PokemonModel with ChangeNotifier {
  // list pokemons for pokemons screen
  bool isFetching = false;
  List<PokemonResults>? pokemonsList;
  Pokemon? pokemon;
  bool? isEnd;
  String? errMsg;

  Future getPokemonDetail(String url) async {
    try {
      final pokemon = ServiceAPI().fetchPokemonDetail(url);
      return pokemon;
    } catch (e) {
      print('[PokeDel] getPokemonDetail Error: $e');
    }
  }

  Future<void> getPokemonItems({bool loadMore = false}) async {
    try {
      isFetching = true;
      isEnd = false;
      notifyListeners();

      String? nextUrl;
      if (pokemon != null && loadMore) {
        nextUrl = pokemon!.next;
      }

      final newPokemon = await ServiceAPI().fetchPokemons(nextUrl: nextUrl);

      isEnd = newPokemon!.results.isEmpty || newPokemon.results.length < 20;

      if (!loadMore) {
        pokemonsList = newPokemon.results;
        pokemon = newPokemon;
      } else {
        pokemonsList = [...pokemonsList!, ...newPokemon.results];
        pokemon = newPokemon;
      }
      isFetching = false;
      errMsg = null;

      print('[PokeDel] getPokemonItems Finish: isEnd: $isEnd');

      notifyListeners();
    } catch (e) {
      errMsg = 'There is an issue with the app during request the data ' +
          e.toString();
      isFetching = false;
      print('[PokeDel] getPokemonItems Error: $e');
    }
  }
}
