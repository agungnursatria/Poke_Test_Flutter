import 'package:bloc/bloc.dart';
import 'package:test_app/bloc/home_event.dart';
import 'package:test_app/bloc/home_service.dart';
import 'package:test_app/bloc/home_state.dart';
import 'package:test_app/dependency_injection/injector.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  @override
  HomeState get initialState => PokemonUninitialized();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    InjectorContainer injector = InjectorContainer();
    HomeService service = injector.getHomeServiceInstance();
    if (event is FetchData){
      try {
        yield PokemonLoading();
        final pokehub = await service.fetchData();
        yield PokemonLoaded(pokeHub: pokehub);
      } catch (_) {
        yield PokemonLoadError();
      }
    } else {
      try {
        yield PokemonLoading();
        final pokehub = await service.fetchData();
        yield PokemonLoaded(pokeHub: pokehub);
      } catch (_) {
        yield currentState;
      }
    }
  }
}