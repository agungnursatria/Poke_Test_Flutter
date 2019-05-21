import 'package:bloc/bloc.dart';
import 'package:test_app/page/home/bloc/home_event.dart';
import 'package:test_app/page/home/service/home_service.dart';
import 'package:test_app/page/home/bloc/home_state.dart';
import 'package:test_app/di/injector.dart';
import 'package:test_app/utility/exception/fetch_data_exception.dart';

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
      yield PokemonLoaded(pokeHub: pokehub);
    } else if (event is RemoveDataDB) {
      final pokehub = (currentState as PokemonLoaded).pokeHub;
      await service.removePokemonFromDB(event.pokemon);
      print('removing pokemon');
      pokehub.pokemon.removeWhere((p) => p.id == event.pokemon.id);
      yield PokemonLoaded(pokeHub: pokehub);
    } else if (event is FetchData) {
      try {
        yield PokemonLoading();
        final pokehub = await service.fetchData();
        await service.clearDB();
        for (int i = 0; i < pokehub.pokemon.length; i++) {
          await service.insertPokemonToDB(pokehub.pokemon[i]);
          print('insert pokemon ${pokehub.pokemon[i].name}');
        }
        yield PokemonLoaded(pokeHub: pokehub);
      } on FetchDataException catch (e) {
        yield PokemonLoadError(message: e.getMessage);
      }
    } else if (event is RemoveData) {
      yield PokemonLoading();
      await service.clearDB();
      yield PokemonRemoved();
    } else {
      // Refresh data
      HomeState curState = (currentState as PokemonLoaded).copyWith();
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
