// ignore_for_file: unnecessary_new

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GetBuilder<SplashScreenController>(builder: (_) {
          return
            new Scaffold(
              body: Container(
                 decoration: const BoxDecoration(
               color: Color(0xFF211414)),
                child: Stack(
                
                children: [
                  new Align(
                    child: Image.asset(
                    "assets/logo.png",
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                  ),
                  ),
                  Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      left: 0.0,
                      child: SizedBox(
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("La Vie de Christ dans toutes Ses PlénitudeS au travers des ondes", style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w800)),
                            SpinKitThreeBounce(
                              color: Colors.redAccent,
                              size: 50.0,
                            )
                          ],
                        ),
                      )),
                ],
              ),
              )
            );
        }),
      ),
    );
  }
}
