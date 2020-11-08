import 'dart:convert';

import 'package:home_exercise/models/order_model.dart';

///Order provider
class OrderProvider{

  ///Get the orders
  ///When the call will be done, it will ask only for documents with a certain restaurantId,
  ///what i did here was done only for testing purposes
  static Future<List<OrderModel>> getOrders(String restaurantId) async{

    ///Firebase call (might not work at first try)
    /*List<DocumentSnapshot> rawOrders = (await References.ordersCollection.where('awaiting', isEqualTo: false).where('restaurantId', isEqualTo: restaurantId).getDocuments()).documents;
    List<OrderModel> orders = new List();
    rawOrders.forEach((element) {
      OrderModel order = OrderModel.fromJson(element.data);
      orders.add(order);
    });*/

    ///Restaurant 01
    var jsonOrder3 = '{"id" : "03", "location" : "Table 22", "time" : "5:32", "message" : "Preparing to order", "username" : "Ink", "awaiting" : false, "restaurantId" : "01"}';
    var jsonOrder4 = '{"id" : "04", "location" : "Table 12", "time" : "0:32", "message" : "Ready for table", "username" : "Argo", "awaiting" : false, "restaurantId" : "01"}';
    var jsonOrder5 = '{"id" : "05", "location" : "Table 9", "time" : "2:18", "message" : "Serving wine", "username" : "Cris", "awaiting" : false, "restaurantId" : "01"}';
    var jsonOrder6 = '{"id" : "06", "location" : "Bar Seat 11-12", "time" : "2:18", "message" : "Looking at menu", "username" : "Carlo", "awaiting" : false, "restaurantId" : "01"}';

    OrderModel order3 = OrderModel.fromJson(jsonDecode(jsonOrder3));
    OrderModel order4 = OrderModel.fromJson(jsonDecode(jsonOrder4));
    OrderModel order5 = OrderModel.fromJson(jsonDecode(jsonOrder5));
    OrderModel order6 = OrderModel.fromJson(jsonDecode(jsonOrder6));

    ///Restaurant 02
    var jsonOrder7 = '{"id" : "07", "location" : "Table 30", "time" : "10:18", "message" : "Serving wine", "username" : "Armin", "awaiting" : false, "restaurantId" : "02"}';
    var jsonOrder8 = '{"id" : "08", "location" : "Bar Seat 20-21", "time" : "2:25", "message" : "Looking at menu", "username" : "Inka", "awaiting" : false, "restaurantId" : "02"}';

    OrderModel order7 = OrderModel.fromJson(jsonDecode(jsonOrder7));
    OrderModel order8 = OrderModel.fromJson(jsonDecode(jsonOrder8));

    List<OrderModel> tmpOrders = new List();
    tmpOrders.add(order3);
    tmpOrders.add(order4);
    tmpOrders.add(order5);
    tmpOrders.add(order6);
    tmpOrders.add(order7);
    tmpOrders.add(order8);

    List<OrderModel> orders = new List();
    tmpOrders.forEach((element) {
      if(element.restaurantId == restaurantId)
        orders.add(element);
    });

    return orders;
  }

  ///Get the awaiting orders
  ///When the call will be done, it will ask only for documents with a certain restaurantId,
  ///what i did here was done only for testing purposes
  static Future<List<OrderModel>> getAwaitings(String restaurantId) async{

    ///Firebase call (might not work at first try)
    /*List<DocumentSnapshot> rawOrders = (await References.ordersCollection.where('awaiting', isEqualTo: true).where('restaurantId', isEqualTo: restaurantId).getDocuments()).documents;
    List<OrderModel> orders = new List();
    rawOrders.forEach((element) {
      OrderModel order = OrderModel.fromJson(element.data);
      orders.add(order);
    });*/

    ///Restaurant 01
    var jsonOrder1 = '{"id" : "01", "location" : "Table 23", "time" : "2:29", "message" : "Looking at menu", "username" : "Pablo", "awaiting" : true, "restaurantId" : "01"}';
    var jsonOrder2 = '{"id" : "02", "location" : "Table 11", "time" : "4:11", "message" : "Looking at menu", "username" : "Mirko", "awaiting" : true, "restaurantId" : "01"}';
    var jsonOrder3 = '{"id" : "03", "location" : "Table 14", "time" : "5:11", "message" : "Looking at menu", "username" : "Flo", "awaiting" : true, "restaurantId" : "01"}';

    OrderModel order1 = OrderModel.fromJson(jsonDecode(jsonOrder1));
    OrderModel order2 = OrderModel.fromJson(jsonDecode(jsonOrder2));
    OrderModel order3 = OrderModel.fromJson(jsonDecode(jsonOrder3));

    ///Restaurant 02
    var jsonOrder9 = '{"id" : "09", "location" : "Table 50", "time" : "3:11", "message" : "Looking at menu", "username" : "Fish", "awaiting" : true, "restaurantId" : "02"}';
    var jsonOrder10 = '{"id" : "10", "location" : "Table 32", "time" : "3:50", "message" : "Looking at menu", "username" : "Akon", "awaiting" : true, "restaurantId" : "02"}';

    OrderModel order9 = OrderModel.fromJson(jsonDecode(jsonOrder9));
    OrderModel order10 = OrderModel.fromJson(jsonDecode(jsonOrder10));


    List<OrderModel> tmpOrders = new List();
    tmpOrders.add(order1);
    tmpOrders.add(order2);
    tmpOrders.add(order3);
    tmpOrders.add(order9);
    tmpOrders.add(order10);

    List<OrderModel> orders = new List();
    tmpOrders.forEach((element) {
      if(element.restaurantId == restaurantId)
        orders.add(element);
    });

    return orders;
  }
}
