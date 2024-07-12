import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/Models/pokemon_model.dart';
import 'dart:math' as math;

import 'package:pokemon_app/View/pokemon_list.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this)..repeat();


  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _controller.clearListeners();
    super.dispose();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),
            () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PokemonList("")))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            child: Container(
              height: 200,
              width: 200,
              child: Center(
                child: Image(image: AssetImage("images/pokemon.png"),),
              ),
            ),
              builder: (BuildContext context, Widget? child){
                return Transform.rotate(angle: _controller.value *2.0 * math.pi,
                    child: child
                );
              }
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Align(
            alignment: Alignment.center,
            child: Text("Pokemon", textAlign: TextAlign.center, style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25),),
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: TextLiquidFill(
          //      text: "Pokemon",
          //     waveColor: Colors.redAccent,
          //     textAlign: TextAlign.center, textStyle: TextStyle(
          //         fontWeight: FontWeight.bold, fontSize: 40),),
          //   ),
        ],
      ),
    );
  }
}
