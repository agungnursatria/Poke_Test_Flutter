import 'package:bloc/bloc.dart';
import 'package:test_app/model/pokemon.dart';
import 'package:test_app/screens/home/bloc/home_event.dart';
import 'package:test_app/screens/home/service/home_service.dart';
import 'package:test_app/screens/home/bloc/home_state.dart';
import 'package:test_app/dependency_injection/injector.dart';
import 'package:test_app/network/exceptionHandler.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => PokemonUninitialized();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    InjectorContainer injector = InjectorContainer();
    HomeService service = injector.getHomeServiceInstance();
    if (event is FetchData) {
      try {
        yield PokemonLoading();
        final pokehub = await service.fetchData();
        yield PokemonLoaded(pokeHub: pokehub);
      } on FetchDataException catch (e) {
        yield PokemonLoadError(message: e.getMessage);
      }
    } else if (event is RemoveData) {
      yield PokemonRemoved();
    } else {
      HomeState curState = (currentState as PokemonLoaded).copyWith();
      try {
        yield PokemonLoading();
        final pokehub = await service.fetchData();
        yield PokemonLoaded(pokeHub: pokehub);
      } catch (_) {
        yield curState;
      }
    }
  }
}
