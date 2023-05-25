import 'package:flutter/material.dart';
import 'package:rick_and_morty/app_router.dart';

void main() {
  runApp( RickandMortyApp(appRouter: App_Router(),));
}

class RickandMortyApp extends StatelessWidget {
  final App_Router appRouter;
  RickandMortyApp({required this.appRouter});


  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
             debugShowCheckedModeBanner: false,
             onGenerateRoute: appRouter.generateRoute,

    );
  }


}


