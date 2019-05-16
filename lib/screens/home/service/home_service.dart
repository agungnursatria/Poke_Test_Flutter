import 'package:test_app/model/pokemon.dart';
import 'package:test_app/network/network_interface.dart';

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
        throw Exception('Error fetch data');
      }
    });
    return pokehub;
  }
}