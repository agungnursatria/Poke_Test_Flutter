import 'package:equatable/equatable.dart';
import 'package:test_app/utility/framework/application.dart';

abstract class LandingState extends Equatable {
  LandingState([List props = const []]) : super(props);
}

class UninitializedState extends LandingState{}
class InitializedState extends LandingState{
  Application application;

  InitializedState({this.application});
}