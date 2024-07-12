import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/pokemon_about_model.dart';
import '../Models/pokemon_detail_model.dart';
import '../Models/pokemon_model.dart';

class Api {
String pokemonListUrl = "https://pokeapi.co/api/v2/pokemon/";

  Future<PokemonDataModel?> fetchPokemonList(String url) async {
    if(url.isNotEmpty){
      pokemonListUrl = url;

    }
    print('Inisden API>>> $pokemonListUrl');
    final response = await http.get(Uri.parse(pokemonListUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      print(decodedData);
      return PokemonDataModel.fromJson(decodedData); // Fix here
    } else {
      throw Exception("Something happened");
    }
  }

  Future<PokemonDetailModel?> fetchDetail(String url) async{
    final response = await http.get(Uri.parse(url));
    if(response.statusCode== 200){
      final decodedData = json.decode(response.body);
      print(decodedData);
      return PokemonDetailModel.fromJson(decodedData);
    }else{
      throw Exception("something Happend");
    }
  }

    Future<String?> fetchDetailOnIndex(dynamic index) async{
    String baseUrl = "https://pokeapi.co/api/v2/pokemon/$index/";
    final response = await http.get(Uri.parse(baseUrl));
    if(response.statusCode== 200){
      final decodedData = json.decode(response.body);
      print(decodedData);
      PokemonDetailModel model = PokemonDetailModel.fromJson(decodedData);
      return model.sprites?.other?.dreamWorld?.frontDefault;
    }else{
      throw Exception("something Happend");
    }
  }



  Future<PokemonAboutModel?> fetchAbout(String url) async{
    final response = await http.get(Uri.parse(url));
    if(response.statusCode== 200){
      final decodedData = json.decode(response.body);
      print(decodedData);
      return PokemonAboutModel.fromJson(decodedData);
    }else{
      throw Exception("something Happend");
    }
  }
}
