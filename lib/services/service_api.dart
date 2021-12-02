import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/entities/pokemon.dart';

class ServiceAPI {
  Future<Pokemon?> fetchPokemons(String? nextUrl) async {
    try {
      var url = 'https://pokeapi.co/api/v2/pokemon';

      if (nextUrl != null) {
        url = nextUrl;
      }
      // var endPoint = '?';
      // endPoint += 'offset=$offset&limit=20';
      // var url = 'https://pokeapi.co/api/v2/pokemon?$endPoint';
      print('[Service] fetchPokemon Url: $url');

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var item = Pokemon.fromJson(body);
        // print('[Service] fetchPokemon Res: $item');
        return item;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future fetchPokemonDetail(String url) async {
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        // var item = Pokemon.fromJson(body);
        print('[Service] fetchPokemonDetail Res: $body');
        return body;
      }
    } catch (e) {
      rethrow;
    }
  }
}
