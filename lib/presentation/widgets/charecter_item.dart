import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/my_colors.dart';
import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/data/models/charectar_model.dart';

class CharacterItem extends StatelessWidget {

final Charecter character;

  const CharacterItem({Key? key,required this.character}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.3,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.my_Yellow,
        borderRadius: BorderRadius.circular(8),
         ),
      child: InkWell(
        onTap: ()=>Navigator.pushNamed(context,DetailsOfCharacters,arguments: character),
        child: GridTile(
          child: Hero(
            tag: character.charId,
            child: Container(
              height: MediaQuery.of(context).size.height*0.3,
              color: MyColors.my_Yellow,
              child: character.image.isNotEmpty?
              FadeInImage.assetNetwork(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  placeholder:'assets/images/loading.gif', image: character.image):Image.asset('assets/images/noPerson.png',fit: BoxFit.fill,),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child:  Text("${character.name}",style: const TextStyle(
              fontSize: 16,height: 1.3,color: MyColors.my_White,
              fontWeight: FontWeight.bold
            ),
            overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),

    );
  }
}
