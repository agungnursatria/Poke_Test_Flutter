import 'package:flutter/material.dart';
import 'package:test_app/model/pokemon.dart';
import 'detail.dart';

class HomePageView extends StatelessWidget {
  PokeHub pokeHub;

  HomePageView({
    Key key,
    @required this.pokeHub
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: pokeHub.pokemon
          .map((poke) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PokeDetail(pokemon: poke,))
                      );
                  },
                  child: Hero(
                    tag: poke.img,
                    child: Card(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(poke.img))),
                          ),
                          Text(
                            poke.name,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}