import 'package:bloc/bloc.dart';
import 'package:test_app/page/home/bloc/home_event.dart';
import 'package:test_app/page/home/service/home_service.dart';
import 'package:test_app/page/home/bloc/home_state.dart';
import 'package:test_app/di/injector.dart';
import 'package:test_app/utility/exception/fetch_data_exception.dart';
import 'package:test_app/utility/log/log.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => PokemonUninitialized();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    InjectorContainer injector = InjectorContainer();
    HomeService service = injector.getHomeServiceInstance();
    if (event is FetchDataDB) {
      yield PokemonLoading();
      final pokehub = await service.fetchDB();
      if (pokehub.pokemon == null) {
        yield PokemonDBEmpty();
      } else {
        yield PokemonLoaded(pokeHub: pokehub);
      }
    } else if (event is RemoveDataDB) {
      await service.removePokemonFromDB(event.pokemon);
      final pokehub = (currentState as PokemonLoaded).pokeHub;
      pokehub.pokemon.removeWhere((p) => p.id == event.pokemon.id);
      yield PokemonLoaded(pokeHub: pokehub);
    } else if (event is FetchData) {
      try {
        yield PokemonLoading();
        final pokehub = await service.fetchData();
        await service.clearDB();
        for (int i = 0; i < pokehub.pokemon.length; i++) {
          await service.insertPokemonToDB(pokehub.pokemon[i]);
        }
        yield PokemonLoaded(pokeHub: pokehub);
      } on FetchDataException catch (e) {
        yield PokemonLoadError(message: e.message);
      }
    } else if (event is RemoveData) {
      yield PokemonLoading();
      await service.clearDB();
      yield PokemonRemoved();
    } else {
      HomeState curState = currentState;
      try {
        yield PokemonLoading();
        final pokehub = await service.fetchData();
        await service.clearDB();
        for (int i = 0; i < pokehub.pokemon.length; i++) {
          await service.insertPokemonToDB(pokehub.pokemon[i]);
        }
        yield PokemonLoaded(pokeHub: pokehub);
      } catch (_) {
        yield curState;
      }
    }
  }
}
