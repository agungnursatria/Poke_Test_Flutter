import 'package:equatable/equatable.dart';
import 'package:test_app/data/model/pokemon.dart';

abstract class HomeState extends Equatable {
  HomeState([List props = const []]) : super(props);
}

class PokemonLoaded extends HomeState{
  PokeHub pokeHub;

  PokemonLoaded({
    this.pokeHub
  });

  PokemonLoaded copyWith({
    PokeHub pokeHub
  }) {
    return PokemonLoaded(
      pokeHub: pokeHub ?? this.pokeHub
    );
  }
}

class PokemonUninitialized extends HomeState{}
class PokemonLoading extends HomeState{}
class PokemonRemoved extends HomeState{}
class PokemonLoadError extends HomeState{
  String message;

  PokemonLoadError({this.message});
}