
import 'package:flutter/material.dart';
import 'package:home_exercise/blocs/orders_bloc.dart';
import 'package:home_exercise/interface/mobile/widgets/order_list_item_widget.dart';
import 'package:home_exercise/models/manager_model.dart';
import 'package:home_exercise/models/order_model.dart';
import 'package:home_exercise/models/restaurant_model.dart';
import 'package:home_exercise/utils/utils.dart';
import 'package:intl/intl.dart';

class CustomersPage extends StatefulWidget {
  //static String route = '/home';
  ManagerModel manager;
  RestaurantModel restaurant;
  CustomersPage(this.manager, this.restaurant);
  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {

  OrdersBloc ordersBloc;
  ManagerModel manager;
  RestaurantModel restaurant;

  @override
  void initState() {
    super.initState();
    ordersBloc = new OrdersBloc();
    manager = widget.manager;
    restaurant = widget.restaurant;
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!';
    }
    if (hour < 17) {
      return 'Good Afternoon!';
    }
    return 'Good Evening!';
  }

  @override
  Widget build(BuildContext context) {

    ordersBloc.getAwaitings(manager.restaurantId);
    ordersBloc.getOrders(manager.restaurantId);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 115,
                  //width: double.infinity,
                  //color: Colors.deepOrange,
                  child: Stack(
                    children: [
                      ///Worker card & Business logo
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ///Worker card
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(top: 25.0, left: 15.0),
                                    color: Colors.transparent,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ///Welcome message 'Hi ...'
                                        Container(
                                          child: Text(
                                            'Hi ${manager.name}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20
                                            ),
                                          ),
                                        ),
                                        ///Welcome message 'Good ...'
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            greeting(),
                                            style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                fontSize: 16
                                            ),
                                          ),
                                        ),
                                        ///Worker shift
                                        Container(
                                          margin: EdgeInsets.only(top: 2.5),
                                          child: Row(
                                            children: [
                                              ///Your
                                              Container(
                                                child: Text(
                                                  'Your ',
                                                  style: TextStyle(
                                                    //fontWeight: FontWeight.bold,
                                                      fontSize: 16
                                                  ),
                                                ),
                                              ),
                                              ///Shift hours
                                              Container(
                                                child: Text(
                                                  '${manager.shift} ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16
                                                  ),
                                                ),
                                              ),
                                              ///shift
                                              Container(
                                                child: Text(
                                                  'shift',
                                                  style: TextStyle(
                                                    //fontWeight: FontWeight.bold,
                                                      fontSize: 16
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                ///Business logo
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        //color: Colors.deepOrange,
                                        width: 140,
                                        child: Image.asset(
                                            restaurant.image,
                                            fit: BoxFit.none,
                                            scale: 1.1
                                        ),
                                      )
                                    ]
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      ///Appbar bottom arc
                      Positioned.fill(
                        top: -10,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Utils.bottomArc,
                        ),
                      ),
                    ],
                  ),
                ),
                ///Awaiting to order text
                Container(
                  margin: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      Text(
                        'Awaiting to order',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ],
                  )
                ),
                Flexible(
                  flex: 1,
                  child: StreamBuilder<List<OrderModel>>(
                    stream: ordersBloc.awaitings,
                    builder: (context, AsyncSnapshot<List<OrderModel>> awaitingsSnapshot) {
                      Widget widget;
                      switch(awaitingsSnapshot.connectionState){
                        case ConnectionState.waiting:
                          widget = Center(child: CircularProgressIndicator());
                          break;
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.done:
                          widget = ListView.separated(
                            shrinkWrap: true,
                            itemCount: awaitingsSnapshot.data.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index){
                              OrderModel order = awaitingsSnapshot.data.elementAt(index);
                              return InkWell(
                                onTap: (){
                                  debugPrint('You tapped item ${index}');
                                },
                                child: OrderListItemWidget(order),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => Padding(
                              padding: EdgeInsets.only(left: 60.0, right: 10.0),
                              child: Divider(
                                color: Colors.grey,
                                height: 1.0,
                              ),
                            ),
                          );

                          break;
                      }
                      ordersBloc.getAwaitings(manager.restaurantId);
                      return widget;
                    },
                  ),
                ),
                ///Table orders text
                Container(
                    margin: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: [
                        Text(
                          'Table orders',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        ),
                      ],
                    )
                ),
                Flexible(
                  child: StreamBuilder<List<OrderModel>>(
                    stream: ordersBloc.orders,
                    builder: (context, AsyncSnapshot<List<OrderModel>> ordersSnapshot) {
                      Widget widget;
                      switch(ordersSnapshot.connectionState){
                        case ConnectionState.waiting:
                          widget = Center(child: CircularProgressIndicator());
                          break;
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.done:
                          widget = ListView.separated(
                            shrinkWrap: true,
                            itemCount: ordersSnapshot.data.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index){
                              OrderModel order = ordersSnapshot.data.elementAt(index);
                              return InkWell(
                                onTap: (){
                                  debugPrint('You tapped item ${index}');
                                },
                                child: OrderListItemWidget(order),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => Padding(
                              padding: EdgeInsets.only(left: 60.0, right: 10.0),
                              child: Divider(
                                color: Colors.grey,
                                height: 1.0,
                              ),
                            ),
                          );

                          break;
                      }
                      //usersBloc.getUsers();
                      return widget;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}