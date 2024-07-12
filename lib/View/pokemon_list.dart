import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_app/Api/api_service.dart';
import 'package:pokemon_app/Models/pokemon_detail_model.dart';
import 'package:pokemon_app/Models/pokemon_model.dart';
import 'package:pokemon_app/View/pokemon_detail_screen.dart';

class PokemonList extends StatefulWidget {
  final String? url;

  const PokemonList(this.url,{Key? key}) : super(key: key);

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
 PokemonDataModel pokemonData = PokemonDataModel();
 Api api = Api();
  String nextPageUrl ="";
  PokemonDetailModel pokemonDetailModel = PokemonDetailModel();
  List<dynamic> listImagePokemon = [];

  @override
  void initState() {
    super.initState();
   apiCalling();

    print('Pokemon Data>>>>> ${widget.url}');
  }

  void apiCalling()  async {
    //   if( widget.url == null){
    // pokemonData = (await api.fetchPokemonList(""))!;
    // }else{
    //   pokemonData = (await api.fetchPokemonList(widget.url ?? ""))!;
    // }


  }

  void _loadPrevious() {}

  void _loadNext() {

  }

  String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pokemon',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<PokemonDataModel?>(
        future:widget.url =="" ? api.fetchPokemonList("") : api.fetchPokemonList(widget.url.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            nextPageUrl = snapshot.data?.next ?? "";
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items in one row
                crossAxisSpacing: 8.0, // Spacing between items horizontally
                mainAxisSpacing: 8.0, // Spacing between items vertically
              ),
              itemCount: snapshot.data?.results?.length ?? 0,
              itemBuilder: (context, index) {
             //   print('Respons>>> ${Api().fetchDetailOnIndex(index)}');
                // listImagePokemon.add( Api().fetchDetailOnIndex(index));
                String indexPage = snapshot.data!.results![index].url![34];
                print('Index of:::: $indexPage');
                  final pokemon = snapshot.data!.results![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PokemonDetail(
                          name: pokemon.name.toString(),
                          url: pokemon.url.toString(),
                        ),
                      ),
                    );
                  },
                  child: GridTile(
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder(

                              future: api.fetchDetailOnIndex(snapshot.data?.results?[index].url?.split("mon/").last) ,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else if (snapshot.hasData) {
                                  return CircleAvatar(
                                    radius: 60,
                                    child: SvgPicture.network(snapshot.data ?? ""),
                                  ) ;
                                }else {
                                  return Center(child: Text('No data available.'));
                                }
                              }), // CircleAvatar(
                          //   backgroundColor: Colors.white,
                          //   child: Text(pokemon.name![0].toUpperCase() ?? ""),
                          // ),

                          SizedBox(height: 8.0),
                          Text(
                            capitalize(pokemon.name ?? ''),
                            style: GoogleFonts.salsa(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: (){

                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PokemonList(nextPageUrl)));
                },
              ),
            ],
          ),
        )
    );
  }
}
