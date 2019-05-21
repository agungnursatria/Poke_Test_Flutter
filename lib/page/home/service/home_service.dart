import 'package:test_app/data/db/db_appstore_repository.dart';
import 'package:test_app/data/model/pokemon.dart';
import 'package:test_app/utility/exception/fetch_data_exception.dart';
import 'package:test_app/data/network/network_interface.dart';

class HomeService{
  final NetworkInterface networkInterface;
  DBAppStoreRepository _dbAppStoreRepository; 

  HomeService(this.networkInterface, this._dbAppStoreRepository);

  Future<PokeHub> fetchData() async {
    PokeHub pokehub = await networkInterface.requestGet(
      path: '/Biuni/PokemonGO-Pokedex/master/pokedex.json', 
    ).then((responseModel){
      if (responseModel.code == 200) {
        return PokeHub.fromJson(responseModel.response);
      } else {
        throw FetchDataException(responseModel.error);
      }
    });
    return pokehub;
  }

  Future<PokeHub> fetchDB() async {
    var list = await _dbAppStoreRepository.getAllPokemon();
    PokeHub pokeHub = PokeHub(pokemon: list);
    return pokeHub;
  }

  Future<int> removePokemonFromDB(Pokemon poke) async {
    var id = await _dbAppStoreRepository.delete(poke);
    return id;
  }

  Future<int> insertPokemonToDB(Pokemon poke) async {
    var id = await _dbAppStoreRepository.insert(poke);
    return id;
  }

  Future<void> clearDB() async {
    await _dbAppStoreRepository.deleteAllPokemon();
  }
}