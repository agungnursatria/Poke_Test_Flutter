import 'dart:async';

import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:test_app/di/injector.dart';
import 'package:test_app/environment/env.dart';
import 'package:test_app/page/home/bloc/home_bloc.dart';
import 'package:test_app/page/home/bloc/home_event.dart';
import 'package:test_app/page/home/bloc/home_state.dart';
import 'package:test_app/utility/connection/connection_status.dart';
import 'package:test_app/config/localization/i18n.dart';
import 'package:test_app/widget/atom/center_text.dart';
import 'package:test_app/page/home/homepage_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const String PATH = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;
  Connection _connection;
  Alice alice;

  @override
  void initState() {
    super.initState();
    _connection = Connection(onRefreshScreen: onRefreshScreen);
    _connection.initConnectivity(mounted);
    _connection.startListen();

    InjectorContainer injectorContainer = InjectorContainer();
    alice = injectorContainer.getAliceInstance();

    _homeBloc = HomeBloc();
    _homeBloc.dispatch(FetchDataDB());
  }

  @override
  void dispose() {
    _connection.dispose();
    _homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Env.appName),
          backgroundColor: Theme.of(context).primaryColor,
          actions: (Env.isDebug())
              ? <Widget>[
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      alice.showInspector();
                    },
                  )
                ]
              : null,
        ),
        body: BlocListener(
          bloc: _homeBloc,
          listener: (BuildContext context, HomeState state) {
            if (state is PokemonLoadError && !_connection.isOffline) {
              Timer(Duration(seconds: 5), () => _homeBloc.dispatch(FetchData()));
            }
          },
          child: BlocBuilder(
            bloc: _homeBloc,
            builder: (BuildContext context, HomeState state) {
              if (state is PokemonUninitialized || state is PokemonLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is PokemonLoadError) {
                if (_connection.isOffline) {
                  return CenterText(
                    text: state.message,
                  );
                } else {
                  return CenterText(
                    text:
                        "${state.message}\n\n${S.of(context).retringIn5Second}",
                  );
                }
              }
              if (state is PokemonLoaded) {
                return (state.pokeHub.pokemon.isEmpty)
                    ? CenterText(
                        text: S.of(context).emptypokemon,
                      )
                    : HomePageView(
                        pokeHub: state.pokeHub,
                        onLongpress: (poke) =>
                            _homeBloc.dispatch(RemoveDataDB(pokemon: poke)),
                      );
              }
              if (state is PokemonRemoved) {
                return CenterText(
                  text: S.of(context).emptypokemon,
                );
              }
              if (state is PokemonDBEmpty) {
                _homeBloc.dispatch(FetchData());
                return Container();
              }
            },
          ),
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'fab_remove',
              onPressed: () {
                if (_homeBloc.currentState is PokemonLoaded) {
                  _homeBloc.dispatch(RemoveData());
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
              heroTag: 'fab_refresh',
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
            title: new Text(S.of(context).closeDialogTitle),
            content: new Text(S.of(context).closeDialog),
            actions: <Widget>[
              FlatButton(
                child: Text(S.of(context).no),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text(S.of(context).yes),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
    );
  }

  onRefreshScreen() {
    if (_homeBloc.currentState is PokemonLoadError && !_connection.isOffline) {
      _homeBloc.dispatch(FetchData());
    }

    if (_homeBloc.currentState is PokemonLoaded && !_connection.isOffline) {
      if ((_homeBloc.currentState as PokemonLoaded).pokeHub.pokemon[0].num ==
          '') {
        _homeBloc.dispatch(FetchData());
      }
    }
  }
}
