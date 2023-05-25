import 'package:rick_and_morty/data/web_services/characters_web_service.dart';
import 'package:rick_and_morty/data/models/charectar_model.dart';

class CharacterRepository{
  final CharactersWebServices charactersWebServices;

  CharacterRepository(this.charactersWebServices);

  Future<List<Charecter>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters.map((character) => Charecter.fromJson(character)).toList();
  }
}
