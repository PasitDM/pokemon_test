import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/entities/pokemon.dart';
import '../../widgets/pokemon/pokemon_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _offset = 0;

  Future<Pokemon?> fetchPokemonList() async {
    try {
      var endPoint = '?';
      endPoint += 'offset=$_offset&limit=20';
      var url = 'https://pokeapi.co/api/v2/pokemon?$endPoint';
      print('[Home] Url: $url');

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var item = Pokemon.fromJson(body);
        // print('[Home] Res: $item');
        return item;
        // return
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> onRefresh() async {
    _offset = 0;
    await fetchPokemonList();
  }

  void onLoadMore() {
    _offset += 20;
    fetchPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        centerTitle: true,
      ),
      body: FutureBuilder<Pokemon?>(
        future: fetchPokemonList(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              // print('[Home] Res: ${snapshot.data!}');
              Pokemon data = snapshot.data;

              return PokemonList(
                pokemons: data.results,
                onRefresh: onRefresh,
                onLoadMore: onLoadMore,
              );

              // return ListView.builder(
              //   itemCount: data.results.length,
              //   itemBuilder: (context, index) {
              //     return ListTile(
              //       title: Text(data.results[index].name),
              //     );
              //   },
              // );
            } else {
              return const Text('No Data');
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
