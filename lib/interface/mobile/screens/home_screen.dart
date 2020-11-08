import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_exercise/interface/mobile/pages/home/customers_page.dart';
import 'package:home_exercise/interface/mobile/pages/home/notifications_page.dart';
import 'package:home_exercise/interface/mobile/pages/home/specials_page.dart';
import 'package:home_exercise/models/manager_model.dart';
import 'package:home_exercise/models/restaurant_model.dart';
import 'package:home_exercise/utils/menu_drawer.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  static String route = '/home';

  RestaurantModel restaurant;
  ManagerModel manager;
  HomeScreen({Key key, this.restaurant, this.manager}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ///Bottom tab bar controller
  PersistentTabController _controller;

  ///Models
  RestaurantModel restaurant;
  ManagerModel manager;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    restaurant = widget.restaurant;
    manager = widget.manager;
  }

  ///Tab screens
  List<Widget> _buildScreens() {
    return [
      CustomersPage(manager, restaurant),
      SpecialsPage(),
      NotificationsPage()
    ];
  }

  ///Tab items
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person_2_fill),
        title: ("Customers"),
        activeColor: Colors.black,
        inactiveColor: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.star),
        title: ("Specials"),
        activeColor: Colors.black,
        inactiveColor: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          width: 20,
          height: 20,
          child: Stack(
            children: [
              Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(CupertinoIcons.bell_fill),
                  )
              ),
              Positioned.fill(
                  top: 12.5,
                  left: 12.5,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
        title: ("Notifications"),
        activeColor: Colors.black,
        inactiveColor: Colors.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(restaurant.name)
          ],
        ),
        actions: [
          Container(
            width: 50,
            child: IconButton(
              onPressed: ()async{
                String url = restaurant.phonenumber.trim();
                debugPrint('Restaurant phonenumber: ' + url);
                if (await canLaunch('tel:$url')) {
                  await launch('tel:$url');
                } else {
                  throw 'Could not launch $url';
                }
              },
              icon: Icon(
                  Icons.call
              ),
            ),
          )
        ],
        centerTitle: true,
        backgroundColor: Color(0xff006791),
        elevation: 0,
      ),
      drawer: MenuDrawer(),
      body: SafeArea(
        child: PersistentTabView(
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(), // Redundant here but defined to demonstrate for other than custom style
            confineInSafeArea: true,
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            handleAndroidBackButtonPress: true,
            //popAllScreensOnTapOfSelectedTab: true,
            onItemSelected: (int) {
              setState(() {
                _controller.index = int;
                //_controller.jumpToTab(int);
              }
              ); // This is required to update the nav bar if Android back button is pressed
            },
          customWidget: CustomNavBarWidget( // Your custom widget goes here
              items: _navBarsItems(),
              selectedIndex: _controller.index,
              onItemSelected: (index) {
                setState(() {
                  if(index != 1)
                    _controller.index = index; // NOTE: THIS IS CRITICAL!! Don't miss it!
                });
              },
            ),
            itemCount: 3,
            navBarStyle: NavBarStyle.custom // Choose the nav bar style with this property
        ),
      ),
    );
  }
}

///Custom nav bar class
class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items; // NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
  final ValueChanged<int> onItemSelected;

  CustomNavBarWidget({Key key, this.selectedIndex, @required this.items, this.onItemSelected,});

  ///Build tab items
  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      color: isSelected ? Colors.white : Color(0xff207cc3),
      alignment: Alignment.center,
      height: 56.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                  size: 20.0,
                  color: isSelected
                      ? (item.activeContentColor == null
                      ? item.activeColor
                      : item.activeContentColor)
                      : item.inactiveColor == null
                      ? item.activeColor
                      : item.inactiveColor),
              child: item.icon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(
                  child: Text(
                    item.title,
                    style: TextStyle(
                        color: isSelected
                            ? (item.activeContentColor == null
                            ? item.activeColor
                            : item.activeContentColor)
                            : item.inactiveColor,
                        fontWeight: FontWeight.w400,
                        fontSize: item.titleFontSize),
                  )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Container(
        width: double.infinity,
        height: 56.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            var index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  this.onItemSelected(index);
                },
                child: _buildItem(
                    item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}