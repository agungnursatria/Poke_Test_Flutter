import 'package:test_app/data/model/pokemon.dart';
import 'package:test_app/data/network/exceptionHandler.dart';
import 'package:test_app/data/network/network_interface.dart';

class HomeService{
  final NetworkInterface networkInterface;

  HomeService(this.networkInterface);

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
}