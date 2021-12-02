import 'package:flutter/material.dart';

import '../../common/constants.dart';

class PokemonBottomSheet extends StatelessWidget {
  final Map item;

  PokemonBottomSheet(this.item);

  @override
  Widget build(BuildContext context) {
    var name = item['name'];
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
}
