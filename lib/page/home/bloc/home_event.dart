import 'package:equatable/equatable.dart';
import 'package:test_app/data/model/pokemon.dart';

abstract class HomeEvent extends Equatable{}

class FetchData extends HomeEvent{}
class RefreshData extends HomeEvent{}
class RemoveData extends HomeEvent{}

class FetchDataDB extends HomeEvent{}
class RemoveDataDB extends HomeEvent{
  Pokemon pokemon;

  RemoveDataDB({this.pokemon});
}