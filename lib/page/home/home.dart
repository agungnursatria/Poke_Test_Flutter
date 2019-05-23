import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/utility/connection/connection_status.dart';
import 'package:test_app/env.dart';
import 'package:test_app/utility/language/i18n.dart';
import 'package:test_app/page/home/bloc/home_import.dart';
import 'package:test_app/utility/log/log.dart';
import 'package:test_app/widget/atom/center_text.dart';
import 'package:test_app/page/home/homepage_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomePage extends StatefulWidget {
  static const String PATH = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  HomeBloc _homeBloc;
  Connection _connection;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _connection = Connection(onRefreshScreen: () {
      if (_homeBloc.currentState is PokemonLoadError &&
          !_connection.isOffline) {
        _homeBloc.dispatch(FetchData());
      }

      if (_homeBloc.currentState is PokemonLoaded && !_connection.isOffline) {
        if ((_homeBloc.currentState as PokemonLoaded).pokeHub.pokemon[0].num ==
            '') {
          _homeBloc.dispatch(FetchData());
        }
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
          title: Text(Env.value.appName),
          backgroundColor: Theme.of(context).primaryColor,
          actions: (Env.value.alice != null)
              ? <Widget>[
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      Env.value.alice.showInspector();
                    },
                  )
                ]
              : null,
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
        ) ??
        false;
  }
}
