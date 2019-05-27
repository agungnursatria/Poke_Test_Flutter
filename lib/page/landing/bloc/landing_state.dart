import 'package:equatable/equatable.dart';

abstract class LandingState extends Equatable {
  LandingState([List props = const []]) : super(props);
}

class UninitializedState extends LandingState{}
class InitializedState extends LandingState{}