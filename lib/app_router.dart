import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic/cubit/characters_cubit.dart';
import 'package:rick_and_morty/data/repository/characters_repository.dart';
import 'package:rick_and_morty/data/web_services/characters_web_service.dart';
import 'package:rick_and_morty/presentation/screens/characters_screen.dart';
import 'package:rick_and_morty/presentation/screens/details_screen.dart';

import 'constants/strings.dart';
import 'data/models/charectar_model.dart';

class App_Router{
     late CharacterRepository characterRepository;
     late CharactersCubit charactersCubit;
  App_Router(){
    characterRepository = CharacterRepository(CharactersWebServices());
    charactersCubit =CharactersCubit(characterRepository);
  }

  Route<dynamic>? generateRoute(RouteSettings settings){
     switch(settings.name){
       case allCharactersRoute:
         return MaterialPageRoute(builder: (_)=> BlocProvider(
             create: (BuildContext context) => CharactersCubit(characterRepository),
           child: Characters_Screen()
         ))  ;
       case DetailsOfCharacters:
         final character = settings.arguments as Charecter;
         return MaterialPageRoute(builder: (_)=> DetailsScreen(character:  character,))  ;
     }


  }
}