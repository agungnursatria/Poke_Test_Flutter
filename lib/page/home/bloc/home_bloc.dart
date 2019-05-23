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
      Log.info("Fetch Data DB");
      yield PokemonLoading();
      final pokehub = await service.fetchDB();
      if (pokehub.pokemon == null) {
        yield PokemonDBEmpty();
      } else {
        yield PokemonLoaded(pokeHub: pokehub);
      }
    } else if (event is RemoveDataDB) {
      Log.info("Remove Data DB");
      await service.removePokemonFromDB(event.pokemon);
      final pokehub = (currentState as PokemonLoaded).pokeHub;
      pokehub.pokemon.removeWhere((p) => p.id == event.pokemon.id);
      yield PokemonLoaded(pokeHub: pokehub);
    } else if (event is FetchData) {
      Log.info("Fetch Data Internet");
      try {
        yield PokemonLoading();
        final pokehub = await service.fetchData();
        await service.clearDB();
        for (int i = 0; i < pokehub.pokemon.length; i++) {
          await service.insertPokemonToDB(pokehub.pokemon[i]);
        }
        yield PokemonLoaded(pokeHub: pokehub);
      } on FetchDataException catch (e) {
        Log.info("Failed Fetch Data Internet");
        yield PokemonLoadError(message: e.message);
      }
    } else if (event is RemoveData) {
      Log.info("Remove Data");
      yield PokemonLoading();
      await service.clearDB();
      yield PokemonRemoved();
    } else {
      Log.info("Refresh Data");
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
        Log.info("Failed Refresh Data");
        yield curState;
      }
    }
  }
}
