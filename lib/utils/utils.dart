import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';

class Utils{
  static Widget bottomArc = Container(
    height: 20,
    decoration: BoxDecoration(
        color: Colors.transparent
    ),
    child: Arc(
      arcType: ArcType.CONVEX,
      edge: Edge.BOTTOM,
      height: 5.0,
      //clipShadows: [ClipShadow(color: Colors.black)],
      child: new Container(
        width: double.infinity,
        color: Color(0xff006791),
      ),
    ),
  );
}