import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/data/network/connection_status.dart';
import 'package:test_app/page/home/bloc/home_bloc.dart';
import 'package:test_app/page/home/bloc/home_event.dart';
import 'package:test_app/page/home/bloc/home_state.dart';
import 'package:test_app/utility/log/log.dart';
import 'package:test_app/widget/center_text.dart';
import 'package:test_app/page/home/homepage_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const String PATH = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;
  Connection _connection;

  @override
  void initState() {
    super.initState();

    _connection = Connection(onRefreshScreen: () {
      if (_homeBloc.currentState is PokemonLoadError &&
          !_connection.isOffline) {
        _homeBloc.dispatch(FetchData());
      }
    });
    _connection.initConnectivity(mounted);
    _connection.startListen();

    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.dispatch(FetchDataDB());
  }

  @override
  void dispose() {
    _connection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Poke App"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: BlocBuilder(
          bloc: _homeBloc,
          builder: (BuildContext context, HomeState state) {
            if (state is PokemonUninitialized || state is PokemonLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is PokemonLoadError) {
              Log.info("Connection is offline => ${_connection.isOffline}");
              if (_connection.isOffline) {
                return CenterText(
                  text: state.message,
                );
              } else {
                Timer(Duration(seconds: 5),
                    () => _homeBloc.dispatch(FetchData()));
                return CenterText(
                  text: "${state.message}\n\nRetrying in 5 seconds",
                );
              }
            }
            if (state is PokemonLoaded) {
              return (state.pokeHub.pokemon.isEmpty)
                  ? CenterText(
                      text: "No pokemon here",
                    )
                  : HomePageView(
                      pokeHub: state.pokeHub,
                      onLongpress: (poke) =>
                          _homeBloc.dispatch(RemoveDataDB(pokemon: poke)),
                    );
            }
            if (state is PokemonRemoved) {
              return CenterText(
                text: "No pokemon here",
              );
            }
            if (state is PokemonDBEmpty) {
              _homeBloc.dispatch(FetchData());
              return Container();
            }
          },
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                print('Pressed');
                if (_homeBloc.currentState is PokemonLoaded) {
                  _homeBloc.dispatch(RemoveData());
                  print('Remove Data');
                }
              },
              backgroundColor: Colors.white,
              child: Icon(
                Icons.delete,
                color: Theme.of(context).primaryColor,
              ),
              mini: true,
            ),
            SizedBox(
              height: 8.0,
            ),
            FloatingActionButton(
              onPressed: () {
                _homeBloc.dispatch((_homeBloc.currentState is PokemonLoaded)
                    ? RefreshData()
                    : FetchData());
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit an App'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              ),
        ) ??
        false;
  }
}
