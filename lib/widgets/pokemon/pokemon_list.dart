import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/entities/pokemon.dart';

class PokemonList extends StatefulWidget {
  final List<PokemonResults>? pokemons;
  final bool isFetching;
  final Function? onRefresh;
  final Function? onLoadMore;

  PokemonList({
    this.pokemons,
    this.isFetching = false,
    this.onRefresh,
    this.onLoadMore,
  });

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();

    _refreshController = RefreshController(initialRefresh: false);
  }

  void _onRefresh() async {
    if (!widget.isFetching) {
      widget.onRefresh!();
    }
  }

  void _onLoading() async {
    if (!widget.isFetching) {
      widget.onLoadMore!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonList = widget.pokemons;

    if (pokemonList == null || pokemonList.isEmpty) {
      return const Center(child: Text('No Data'));
    }

    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              print('$index ${pokemonList[index].url}');
              showModalBottomSheet(
                context: context,
                builder: (c) {
                  return Container(child: Text('Hello $index'));
                },
                isScrollControlled: true,
              );
            },
            title: Text(pokemonList[index].name),
          );
        },
      ),
    );
  }
}
