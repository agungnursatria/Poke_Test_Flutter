import 'package:flutter/material.dart';
import 'package:test_app/page/detail/detail.dart';
import 'package:test_app/data/model/pokemon.dart';

class HomePageView extends StatefulWidget {
  final PokeHub pokeHub;
  final Function(Pokemon pokemon) _onLongPress;

  HomePageView({Key key, @required this.pokeHub, onLongpress})
      : assert(pokeHub != null),
        this._onLongPress = onLongpress,
        super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 2,
      children: widget.pokeHub.pokemon
          .map((poke) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PokeDetailPage.PATH,
                        arguments: PokeDetailArguments(pokemon: poke));
                  },
                  onLongPress: () {
                    widget._onLongPress(poke);
                    setState(() {
                      widget.pokeHub.pokemon.remove(poke);
                    });
                  },
                  child: Hero(
                    tag: poke.img,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
