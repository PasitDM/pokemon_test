import 'package:flutter/material.dart';

import '../services/service_api.dart';
import 'entities/pokemon.dart';

class PokemonModel with ChangeNotifier {
  bool isFetching = false; // เช็คว่ากำลังโหลดข้อมูลอยู่หรือไม่
  List<PokemonResults>? pokemonsList; // list pokemon (result = [])
  Pokemon? pokemon; // รวมข้อมูลทั้งหมดเช่น next, previous, results
  bool? isEnd; // เช็คว่าสามารถโหลดโปรเกม่อนได้อีกหรือไม่

  // ดึงค่ารายละเอียดของ Pokemon ตัวนั้น ๆ
  Future<Map?> getPokemonDetail(String url) async {
    try {
      final pokemon = ServiceAPI().fetchPokemonDetail(url);
      return pokemon;
    } catch (e) {
      print('[PokeDel] getPokemonDetail Error: $e');
    }
  }

  // ดึงค่า list pokemon
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

      // ถ้า loadmore = false คือการ Refresh จะทำการ clear pokemonslist ใหม่
      if (!loadMore) {
        pokemonsList = newPokemon.results;
        pokemon = newPokemon;
      }
      // โหลดโปเกม่อนเพิ่ม
      else {
        pokemonsList = [...pokemonsList!, ...newPokemon.results];
        pokemon = newPokemon;
      }
      isFetching = false;

      print('[PokeDel] getPokemonItems Finish: isEnd: $isEnd');

      notifyListeners();
    } catch (e) {
      isFetching = false;
      print('[PokeDel] getPokemonItems Error: $e');
    }
  }
}
