import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:home_exercise/utils/utils.dart';

class SpecialsPage extends StatefulWidget {
  //static String route = '/home';
  @override
  _SpecialsPageState createState() => _SpecialsPageState();
}

class _SpecialsPageState extends State<SpecialsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 20,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        top: -10,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Utils.bottomArc,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}