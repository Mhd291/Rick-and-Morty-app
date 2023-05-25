import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic/cubit/characters_cubit.dart';
import 'package:rick_and_morty/constants/my_colors.dart';
import 'package:rick_and_morty/data/models/charectar_model.dart';


class DetailsScreen extends StatelessWidget {
 final Charecter character;

 DetailsScreen({ Key? key,required this.character}): super (key: key);

 Widget buildSliverAppBar(context) {
  return SliverAppBar(
   leading: IconButton(
    icon: const Icon(Icons.arrow_back_outlined,size: 25,color: Colors.black,),
    onPressed: (){
     Navigator.pop(context);
    },
   ),
   expandedHeight: 460,
   pinned: true,
   stretch: true,
   backgroundColor: MyColors.my_Grey,
   flexibleSpace: FlexibleSpaceBar(
    centerTitle: true,
    title: Text(
     character.name,
     style: const TextStyle(color: MyColors.my_Yellow,fontSize: 25),
    ),
    background: Hero(
     tag: character.charId,
     child: Image.network(
      character.image,
      fit: BoxFit.cover,
     ),
    ),
   ),
  );
 }

 Widget characterInfo(String title, String value) {
  return RichText(
   maxLines: 1,
   overflow: TextOverflow.ellipsis,
   text: TextSpan(
    children: [
     TextSpan(
      text: title,
      style: const TextStyle(
       color: MyColors.my_White,
       fontWeight: FontWeight.bold,
       fontSize: 18,
      ),
     ),
     TextSpan(
      text: value,
      style: const TextStyle(
       color: MyColors.my_White,
       fontSize: 16,
      ),
     ),
    ],
   ),
  );
 }

 Widget buildDivider(double endIndent) {
  return Divider(
   height: 30,
   endIndent: endIndent,
   color: MyColors.my_Yellow,
   thickness: 2,
  );
 }



 Widget showProgressIndicator() {
  return const Center(
   child: CircularProgressIndicator(
    color: MyColors.my_Yellow,
   ),
  );
 }

 @override
 Widget build(BuildContext context) {
  var width =MediaQuery.of(context).size.width;
  var height =MediaQuery.of(context).size.height;
  //BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);
  return Scaffold(
   backgroundColor: MyColors.my_Grey,
   body: CustomScrollView(
    slivers: [
     buildSliverAppBar(context),
     SliverList(
      delegate: SliverChildListDelegate(
       [
        Container(
         margin: EdgeInsets.fromLTRB(width/25, height/33, width/15, 0),
         padding: EdgeInsets.all(8),
         child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           characterInfo('Species : ', character.species),
           buildDivider(250),
           characterInfo(
               'Gender : ', character.gender),
           buildDivider(250),
           characterInfo('Status : ', character.statusIfDeadOrAlive),
           buildDivider(250),

         const  SizedBox(
            height: 20,
           ),
           // BlocBuilder<CharactersCubit, CharactersState>(
           //  builder: (context, state) {
           //   return checkIfQuotesAreLoaded(state);
           //  },
           // ),
          ],
         ),
        ),
         SizedBox(
         height: height*0.65,
        )
       ],
      ),
     ),
    ],
   ),
  );
 }
}
