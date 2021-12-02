import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/entities/index.dart';

class PokemonList extends StatefulWidget {
  final List<PokemonResults>? pokemons;
  final bool isFetching;
  final bool? isEnd;
  final Function? onRefresh;
  final Function? onLoadMore;

  PokemonList({
    this.pokemons,
    this.isFetching = false,
    this.isEnd = true,
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

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PokemonList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isFetching == false && oldWidget.isFetching == true) {
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    }
  }

  void _onRefresh([loadingConfig = true]) async {
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
      enablePullDown: true,
      enablePullUp: widget.isEnd!,
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text('pull up load');
          } else if (mode == LoadStatus.loading) {
            body = const CircularProgressIndicator();
          } else if (mode == LoadStatus.failed) {
            body = const Text('Load Failed!Click retry!');
          } else if (mode == LoadStatus.canLoading) {
            body = const Text('release to load more');
          } else {
            body = const Text('No more Data');
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
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
