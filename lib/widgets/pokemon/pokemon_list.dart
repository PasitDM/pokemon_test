import 'package:flutter/material.dart';
import 'package:pokemon_test_pasit/common/constants.dart';
import 'package:pokemon_test_pasit/models/pokemon_model.dart';
import 'package:provider/provider.dart';
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

    if (pokemonList == null) {
      return const SizedBox();
    }

    if (pokemonList.isEmpty) {
      return const Center(child: Text('No Data'));
    }

    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      enablePullDown: true,
      enablePullUp: !widget.isEnd!,
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
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                context: context,
                builder: (context) {
                  final pokemonModel =
                      Provider.of<PokemonModel>(context, listen: false);

                  return FutureBuilder(
                    future:
                        pokemonModel.getPokemonDetail(pokemonList[index].url),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return Container(
                            padding: const EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        case ConnectionState.done:
                        default:
                          if (snapshot.hasError || snapshot.data == null) {
                            return const SizedBox();
                          }

                          print('[PokeList] snapshot: ${snapshot.data}');
                          var item = snapshot.data;

                          var name = pokemonList[index].name;
                          String frontImg = item['sprites']['front_default'];
                          String backImg = item['sprites']['back_default'];
                          int weight = item['weight'];
                          int height = item['height'];

                          return Container(
                            padding: const EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Column(
                              children: [
                                Container(
                                  height: 5,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  name,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FadeInImage.assetNetwork(
                                      image: frontImg,
                                      placeholder: kLoadPokemon,
                                      // child: Image.network(frontImg),
                                    ),
                                    FadeInImage.assetNetwork(
                                      image: backImg,
                                      placeholder: kLoadPokemon,
                                      // child: Image.network(frontImg),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Weight: ',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '$weight',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Height: ',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '$height',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                      }
                    },
                  );
                },
              );
            },
            title: Text(pokemonList[index].name),
          );
        },
      ),
    );
  }
}
