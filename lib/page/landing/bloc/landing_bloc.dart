import 'package:bloc/bloc.dart';
import 'package:test_app/di/injector.dart';
import 'package:test_app/page/landing/bloc/landing_event.dart';
import 'package:test_app/page/landing/bloc/landing_state.dart';
import 'package:test_app/utility/framework/application.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  @override
  LandingState get initialState => UninitializedState();

  @override
  Stream<LandingState> mapEventToState(LandingEvent event) async* {
    if (event is InitializeLandingPage){
      InjectorContainer injector = InjectorContainer();
      Application application = injector.getAppStoreInstance();
      await application.onCreate();
      yield InitializedState(application: application);
    }
  }

}