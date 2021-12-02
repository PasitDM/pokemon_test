import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/entities/pokemon.dart';

class ServiceAPI {
  Future<Pokemon?> fetchPokemons({String? nextUrl}) async {
    try {
      // ถ้า nextUrl == null ก็จะให้ใช้ api default
      var url = 'https://pokeapi.co/api/v2/pokemon';
      if (nextUrl != null) {
        url = nextUrl;
      }

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var item = Pokemon.fromJson(body);
        return item;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> fetchPokemonDetail(String url) async {
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        return body;
      }
    } catch (e) {
      rethrow;
    }
  }
}
