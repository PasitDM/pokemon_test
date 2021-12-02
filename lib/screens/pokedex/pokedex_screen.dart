import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/index.dart';
import '../../widgets/pokemon/pokemon_list.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({Key? key}) : super(key: key);

  @override
  _PokedexScreenState createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  bool _more = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, onRefresh);
  }

  Future<void> onRefresh() async {
    _more = false;

    print('[Pokedex] onRefresh Ready');
    await Provider.of<PokemonModel>(context, listen: false).getPokemonItems();
    print('[Pokedex] onRefresh Finish');

    return;
  }

  void onLoadMore() {
    _more = true;
    Provider.of<PokemonModel>(context, listen: false)
        .getPokemonItems(loadMore: _more);
  }

  @override
  Widget build(BuildContext context) {
    final pokemonModel = Provider.of<PokemonModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        centerTitle: true,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListenableProvider.value(
              value: pokemonModel,
              child: Consumer<PokemonModel>(
                builder: (BuildContext context, value, Widget? child) {
                  return PokemonList(
                    pokemons: value.pokemonsList,
                    onRefresh: onRefresh,
                    onLoadMore: onLoadMore,
                    isFetching: value.isFetching,
                    isEnd: value.isEnd,
                  );
                },
              ));
        },
      ),
    );
  }
}
