import 'dart:async';

import 'package:covid_tracker_app/view/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  @override

  void dispose(){
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => worldstates())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: const Center(
                    child: Center(
                        child: Image(
                      image: NetworkImage(
                          'https://i.ibb.co/NSzFs7b/Coronavirus-SARS-Co-V-2.png'),
                    )),
                  ),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                }),

            //SizedBox(height: MediaQuery.of(context).size.height * 02,),

            SizedBox(
              height: 30,
            ),
            Center(
                child: Align(
              alignment: Alignment.center,
              child: Text(
                "Covid - 19\nTracker App",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
