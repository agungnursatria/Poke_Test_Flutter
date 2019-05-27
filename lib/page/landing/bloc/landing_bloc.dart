import 'package:bloc/bloc.dart';
import 'package:test_app/page/landing/bloc/landing_event.dart';
import 'package:test_app/page/landing/bloc/landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  @override
  LandingState get initialState => UninitializedState();

  @override
  Stream<LandingState> mapEventToState(LandingEvent event) async* {
    if (event is InitializeLandingPage){
      yield InitializedState();
    }
  }

}