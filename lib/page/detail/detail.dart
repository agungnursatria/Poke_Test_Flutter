import 'package:flutter/material.dart';
import 'package:test_app/config/localization/i18n.dart';
import 'package:test_app/utility/screen_helper.dart';
import 'package:test_app/data/model/pokemon.dart';

class PokeDetailArguments {
  final Pokemon pokemon;

  PokeDetailArguments({this.pokemon}) : assert(pokemon != null);
}

class PokeDetailPage extends StatefulWidget {
  static const String PATH = '/detail';

  @override
  State<StatefulWidget> createState() {
    return PokeDetailState();
  }
}

class PokeDetailState extends State<PokeDetailPage> {
  Pokemon pokemon;

  @override
  void initState() {
    super.initState();
    portraitModeOnly();
  }

  @override
  void dispose() {
    enableRotation();
    super.dispose();
  }

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                  ),
                  Text(
                    pokemon.name,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Text(S.of(context).height + pokemon.height),
                  Text(S.of(context).weight + pokemon.weight),
                  Text(
                    S.of(context).types,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type
                        .map((t) => FilterChip(
                            backgroundColor: Colors.amber,
                            label: Text(t),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  Text(S.of(context).weakness,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses
                        .map((t) => FilterChip(
                            backgroundColor: Colors.red,
                            label: Text(
                              t,
                              style: TextStyle(color: Colors.white),
                            ),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  Text(S.of(context).nextevolution,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.nextEvolution
                        .map((n) => FilterChip(
                            backgroundColor: Colors.green,
                            label: Text(n.name,
                                style: TextStyle(color: Colors.white)),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
                tag: pokemon.img,
                child: Container(
                  height: 170.0,
                  width: 170.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(pokemon.img))),
                )),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    PokeDetailArguments args = ModalRoute.of(context).settings.arguments;
    pokemon = args.pokemon;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(pokemon.name),
      ),
      body: bodyWidget(context),
    );
  }
}
