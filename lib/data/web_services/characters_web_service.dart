import'package:dio/dio.dart';
import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/data/models/charectar_model.dart';

class CharactersWebServices{
late Dio dio;

CharactersWebServices(){
  BaseOptions options =BaseOptions(
    baseUrl: baseUrl,
     receiveDataWhenStatusError: true,
    receiveTimeout: 20*1000,
    connectTimeout: 20*1000,
  );

  dio =Dio(options);
}
Future<List<dynamic>> getAllCharacters () async{
  try{
    Response response =await dio.get('character');
    print(response.data['results']);
    return response.data['results'];
  }
  catch(e)
  {
    print(e.toString());
    return [];
  }
}
}