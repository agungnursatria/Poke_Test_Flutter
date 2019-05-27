import 'package:equatable/equatable.dart';

abstract class LandingState extends Equatable {
  LandingState([List props = const []]) : super(props);
}

class InitialLandingState extends LandingState{}