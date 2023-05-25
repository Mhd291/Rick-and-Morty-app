import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:rick_and_morty/business_logic/cubit/characters_cubit.dart';
import 'package:rick_and_morty/constants/my_colors.dart';
import 'package:rick_and_morty/data/models/charectar_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/widgets/charecter_item.dart';

class Characters_Screen extends StatefulWidget {
  @override
  State<Characters_Screen> createState() => _Characters_ScreenState();
}

class _Characters_ScreenState extends State<Characters_Screen> {
  late List<Charecter> allCharacter;
  late List<Charecter> SearchedForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();


  @override
  void initState() {
    super.initState();
     BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.my_Grey,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.my_Grey, fontSize: 18),
      ),
      style: const TextStyle(color: MyColors.my_Grey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedFOrItemsToSearchedList(searchedCharacter);
      },
    );
  }
  void addSearchedFOrItemsToSearchedList(String searchedCharacter) {
    SearchedForCharacters = allCharacter
        .where((character) =>
        character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }
  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        Padding(
          padding:  EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(Icons.clear, color: MyColors.my_Grey,size: 20,),
          ),
        ),
      ];
    } else {
      return [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: _startSearch,
            icon: Icon(
              Icons.search,
              color: MyColors.my_Grey,
              size: 25,
            ),
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }



  Widget buildCharacterList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4.5,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,

        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty
            ? allCharacter.length
            : SearchedForCharacters.length,
        itemBuilder: (ctx, index) {
          return
           CharacterItem(character:  _searchTextController.text.isEmpty
               ? allCharacter[index]
               : SearchedForCharacters[index],);
          //CharacterItem(character: allCharacter[index],);
        });
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            buildCharacterList(),
          ],
        ),
      ),
    );

  }
  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.my_Yellow,
      ),
    );
  }
  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacter = (state).characters;
        return buildLoadedListWidget();
        setState(() {

        });
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: MyColors.my_Yellow,
          ),
        );
      }
    });
  }
  Widget _buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: MyColors.my_Grey,fontSize: 20),
    );
  }
   Widget buildNoInternetWidget(){
     return Center(
       child: Container(
         color: Colors.white,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
            const  SizedBox(
               height: 20,
             ),
            const  Text(
               'Can\'t connect .. check internet',
               style: TextStyle(
                 fontSize: 22,
                 color: MyColors.my_Grey,
               ),
             ),
             Image.asset('assets/images/no_internet.png')
           ],
         ),
       ),
     );
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.my_Yellow,
        leading: _isSearching
            ? IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back,size: 25,color: Colors.black,))
            : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
         // style: TextStyle(color: MyColors.my_Grey),
        ),

      body:OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          final bool connected = connectivity != ConnectivityResult.none;

          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
