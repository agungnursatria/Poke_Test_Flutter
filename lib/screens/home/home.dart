import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/network/connection_status.dart';
import 'package:test_app/screens/home/bloc/home_bloc.dart';
import 'package:test_app/screens/home/bloc/home_event.dart';
import 'package:test_app/screens/home/bloc/home_state.dart';
import 'package:test_app/screens/home/homepage_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;
  Connection _connection;

  @override
  void initState() {
    super.initState();
    _connection = Connection();
    _connection.initConnectivity(mounted);
    _connection.startListen();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.dispatch(FetchData());
  }

  @override
  void dispose() {
    _connection.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Poke App"),
          backgroundColor: Colors.cyan,
        ),
        body: BlocBuilder(
          bloc: _homeBloc,
          builder: (BuildContext context, HomeState state) {
            if (state is PokemonUninitialized || state is PokemonLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is PokemonLoadError) {
              if (_connection.isOffline) {
                return Center(child: Text("Error fetch data"));
              } else {
                Timer(Duration(seconds: 5),
                    () => _homeBloc.dispatch(FetchData()));
                return Center(child: Text("Retrying in 5 seconds"));
              }
            }
            if (state is PokemonLoaded) {
              return HomePageView(
                pokeHub: state.pokeHub,
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _homeBloc.dispatch((_homeBloc.currentState is PokemonLoaded)
                ? RefreshData()
                : FetchData());
          },
          backgroundColor: Colors.cyan,
          child: Icon(Icons.refresh),
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
