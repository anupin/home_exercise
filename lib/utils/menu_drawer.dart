import 'package:flutter/material.dart';
import 'package:home_exercise/utils/size_config.dart';

// ignore: must_be_immutable
class MenuDrawer extends StatefulWidget {
  static String route = "/home";
  @override
  MenuDrawerState createState() => new MenuDrawerState();
}

class MenuDrawerState extends State<MenuDrawer> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return  Container(
      width: SizeConfig.blockSizeHorizontal * 65,
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          ],
        ),
      ),
    );
  }
}