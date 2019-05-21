import 'package:sqflite/sqflite.dart';
import 'package:test_app/data/model/pokemon.dart';

class DBAppStoreRepository {
  Database _database;

  DBAppStoreRepository(this._database);

  Future<int> insert(Pokemon poke) async {
    PokemonDB pokemonDB = poke.toDB();
    return await _database.insert('Pokemon', pokemonDB.toJson());
  }

  Future<int> delete(Pokemon poke) async{
    return await _database.delete('Pokemon', where: "id = ?", whereArgs: [poke.id]);
  }

  Future<void> deleteAllPokemon() async{
    await _database.rawDelete('DELETE FROM Pokemon');
  }

  Future<List<Pokemon>> getAllPokemon() async {
    var res = await _database.query('Pokemon');
    List<Pokemon> list =
        res.isNotEmpty ? res.map((c) => Pokemon.fromDB(PokemonDB.fromJson(c))).toList() : null;
    return list;
  }
}
