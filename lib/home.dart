import 'package:flutter/material.dart';
import 'package:test_app/bloc/home_bloc.dart';
import 'package:test_app/bloc/home_event.dart';
import 'package:test_app/bloc/home_state.dart';
import 'package:test_app/homepage_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.dispatch(FetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poke App"),
        backgroundColor: Colors.cyan,
      ),
      body: BlocBuilder(
        bloc: _homeBloc,
        builder: (BuildContext context, HomeState state){
          if (state is PokemonUninitialized || state is PokemonLoading){
            return Center(child: CircularProgressIndicator());
          }
          if (state is PokemonLoadError){
            return Center(child: Text(state.message));
          }
          if (state is PokemonLoaded){
            return HomePageView(
              pokeHub: state.pokeHub,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _homeBloc.dispatch(RefreshData());
        },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}