import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_app/Api/api_service.dart';
import 'package:pokemon_app/View/pokemon_list.dart';

import '../Models/pokemon_detail_model.dart';
import '../Reusable_Widgits/reusable_widgit.dart';

class PokemonDetail extends StatefulWidget {
  String name, url;

  PokemonDetail({required this.name, required this.url});

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> with TickerProviderStateMixin {
  Api pokemonDetailApi = Api();

  late TabController tabController;

  String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int index =0;
    tabController = TabController(length: 3, vsync: this, initialIndex: index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(capitalize(widget.name), style: GoogleFonts.salsa(fontSize: 30)),
        //   centerTitle: true,
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: Stack(
          children: [

            SingleChildScrollView(
              child: FutureBuilder<PokemonDetailModel?>(
                future: pokemonDetailApi.fetchDetail(widget.url),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [

                            Container(
                              // height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.deepOrangeAccent,
                                    Colors.green,
                                    Colors.deepPurpleAccent
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Card(
                                    child: Container(
                                    //  height: MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.deepOrangeAccent,
                                            Colors.green,
                                            Colors.deepPurpleAccent
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: MediaQuery.of(context).size.height / 2.5),
                                          Text(capitalize(widget.name), style: GoogleFonts.salsa(fontSize: 30)),
                                          Text(snapshot.data!.gameIndices!.first!.gameIndex.toString(), style: GoogleFonts.salsa(fontSize: 30)),
                                          ReusableRow(title: "Ability", value: snapshot.data!.abilities!.first.ability!.name.toString()),
                                          ReusableRow(title: "Move", value: snapshot.data!.moves!.first.move!.name.toString()),
                                          ReusableRow(title: "Base Experience", value: snapshot.data!.baseExperience.toString()),
                                          ReusableRow(title: "Weight", value: snapshot.data!.weight.toString()),
                                          Center(child:
                                          Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Container(
                                              width: 170,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: Colors.white),
                                                  color: Colors.transparent
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("Height : ${snapshot.data!.height.toString()}", style: GoogleFonts.arvo(fontSize: 22),),
                                                    Icon(Icons.height)
                                                  ],
                                                ),
                                              ),),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  TabBar(
                                      controller: tabController,
                                      tabs: [
                                    Text("Abilities", style: TextStyle(fontSize: 18),),
                                    Text("Power", style: TextStyle(fontSize: 18),),
                                        Text("Moves", style: TextStyle(fontSize: 18),),
                                  ]),
                                  Container(
                                    width: double.maxFinite,
                                    height: 200,
                                    child: Align(
                                      child: TabBarView(
                                          controller: tabController,
                                          children: [
                                            Center(child:
                                             Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: Colors.white),
                                                color: Colors.transparent
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Text(snapshot.data?.abilities?.first.ability?.name ?? "", style: GoogleFonts.arvo(fontSize: 25),),
                                              ),)),
                                            Center(child:
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: Colors.white),
                                                  color: Colors.transparent
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Text(snapshot.data?.abilities?[1].ability?.name ?? "", style: GoogleFonts.arvo(fontSize: 25),),
                                              ),)),
                                            Center(child:
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: SingleChildScrollView(
                                                physics: NeverScrollableScrollPhysics(),
                                                child: Column(
                                                  children: [
                                                    ReusableRow(title: snapshot.data!.moves!.first!.versionGroupDetails!.first!.moveLearnMethod!.name.toString(),
                                                      value: snapshot.data!.moves!.first!.versionGroupDetails!.first!.versionGroup!.name.toString()),
                                                    // ReusableRow(title: snapshot.data!.moves!.first!.versionGroupDetails![2]!.moveLearnMethod!.name.toString(),
                                                    //   value: snapshot.data!.moves!.first!.versionGroupDetails![2]!.versionGroup!.name.toString()),



                                                    
                                                  ],
                                                ),
                                              ),
                                            )),

                                      ]),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Align(alignment: Alignment.topLeft,
                                    child: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black,),
                                      onPressed: () {Navigator.of(context).pop();},)),
                                // Text(capitalize(widget.name), style: GoogleFonts.salsa(fontSize: 30))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: SvgPicture.network(
                                snapshot.data!.sprites!.other!.dreamWorld!.frontDefault ?? '',
                                height: MediaQuery.of(context).size.shortestSide / 1.4,
                              ),
                            )
                          ],
                        ),

                      ],
                    );
                  } else {
                    return Center(child: Text('No data available.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
