import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/data/models/charectar_model.dart';
import 'package:rick_and_morty/data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;
   List<Charecter> characters =[];
  CharactersCubit(this.characterRepository) : super(CharactersInitial());

 List<Charecter> getAllCharacters(){
   characterRepository.getAllCharacters().then((characters) {
     emit(CharactersLoaded(characters));
     this.characters =characters;
   });
   return characters;
 }


}
