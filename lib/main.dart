import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_exercise/interface/mobile/screens/home_screen.dart';
import 'package:home_exercise/models/manager_model.dart';
import 'package:home_exercise/models/restaurant_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ///Models
  RestaurantModel restaurant;
  ManagerModel manager;

  @override
  void initState() {
    super.initState();
    ///Init Restaurant
    var jsonRestaurant1 = '{"id" : "01", "name" : "Restaurant Night Leaf", "phonenumber" : "111 111 1111", "image" : "assets/images/business_logo.png"}';
    var jsonRestaurant2 = '{"id" : "02", "name" : "Restaurant Day Leaf", "phonenumber" : "222 222 2222", "image" : "assets/images/business_logo2.png"}';

    ///Init Manager
    var jsonManager1 = '{"id" : "01", "name" : "Alice", "surname" : "Chioccia", "shift" : "11:00 - 15:30", "restaurantId" : "01"}';
    var jsonManager2 = '{"id" : "02", "name" : "Riccardo", "surname" : "Covik", "shift" : "15:30 - 00:00", "restaurantId" : "02"}';

    manager = ManagerModel.fromJson(jsonDecode(jsonManager1)); ///Change jsonManager1|2 to see different cases and hot restart

    if(manager.restaurantId.endsWith('1'))
      restaurant = RestaurantModel.fromJson(jsonDecode(jsonRestaurant1));
    else
      restaurant = RestaurantModel.fromJson(jsonDecode(jsonRestaurant2));
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); ///Only portrait

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Exercise',
      home: HomeScreen(restaurant: restaurant, manager: manager),
      routes: {
        HomeScreen.route: (context) => HomeScreen(),
      },
    );
  }
}


