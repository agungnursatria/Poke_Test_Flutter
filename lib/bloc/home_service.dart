
import 'dart:convert';
import 'package:test_app/model/pokemon.dart';
import '../network_interface.dart';

class HomeService{
  final NetworkInterface networkInterface;

  HomeService(this.networkInterface);

  Future<PokeHub> fetchData() async {
    final response = await networkInterface.httpClient.get(
        'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json');
    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      return PokeHub.fromJson(decodedJson);
    } else {
      throw Exception('error getting weather for location');
    }
  }
}