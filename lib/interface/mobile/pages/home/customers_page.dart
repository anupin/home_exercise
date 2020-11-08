import 'package:flutter/material.dart';
import 'package:home_exercise/blocs/orders_bloc.dart';
import 'package:home_exercise/interface/mobile/widgets/order_list_item_widget.dart';
import 'package:home_exercise/models/manager_model.dart';
import 'package:home_exercise/models/order_model.dart';
import 'package:home_exercise/models/restaurant_model.dart';
import 'package:home_exercise/utils/size_config.dart';
import 'package:home_exercise/utils/utils.dart';

// ignore: must_be_immutable
class CustomersPage extends StatefulWidget {
  //static String route = '/home';
  ManagerModel manager;
  RestaurantModel restaurant;
  CustomersPage(this.manager, this.restaurant);

  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  ///ORders bloc
  OrdersBloc ordersBloc;
  ///Models
  ManagerModel manager;
  RestaurantModel restaurant;

  @override
  void initState() {
    super.initState();
    ordersBloc = new OrdersBloc();
    manager = widget.manager;
    restaurant = widget.restaurant;
  }

  ///Greetings method
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
    ///Init sizeConfig
    SizeConfig().init(context);

    ordersBloc.getAwaitings(manager.restaurantId);
    ordersBloc.getOrders(manager.restaurantId);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: [
                ///Appabar bottom arc & Worker card & Business logo
                Container(
                  height: 115, ///Fixed height
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
                                        width: 140, ///Fixed width
                                        child: Image.asset(
                                            restaurant.image,
                                            fit: BoxFit.cover,
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
                  margin: EdgeInsets.only(left: 15.0), ///Left margin
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
                ///Awaiting orders list
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
                                  debugPrint('You tapped item ${++index}');
                                },
                                child: OrderListItemWidget(order),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => Padding(
                              padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 20, right: 10.0), ///Padding 20% of the screen width on left and 10 on right
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
                    margin: EdgeInsets.only(left: 15.0), ///Left margin
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
                ///Table ordes list
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
                                  debugPrint('You tapped item ${++index}');
                                },
                                child: OrderListItemWidget(order),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => Padding(
                              padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 20, right: 10.0), ///Padding 20% of the screen width on left and 10 on right
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