import 'package:bloc/bloc.dart';
import 'package:test_app/page/landing/bloc/landing_event.dart';
import 'package:test_app/page/landing/bloc/landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  
  @override
  // TODO: implement initialState
  get initialState => InitialLandingState();

  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    return null;
  }

}