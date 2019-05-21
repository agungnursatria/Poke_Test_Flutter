import 'package:flutter/material.dart';
import 'package:test_app/page/detail/detail.dart';
import 'package:test_app/data/model/pokemon.dart';

class HomePageView extends StatefulWidget {
  final PokeHub pokeHub;

  HomePageView({Key key, @required this.pokeHub})
      : assert(pokeHub != null),
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
                    Navigator.pushNamed(context, '/detail',
                        arguments: PokeDetailArguments(pokemon: poke));
                  },
                  onLongPress: () {
                    setState(() {
                      widget.pokeHub.pokemon.remove(poke);
                    });
                    print("Remove : ${poke.name}");
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
