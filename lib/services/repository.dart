import 'package:home_exercise/models/notification_model.dart';
import 'package:home_exercise/models/order_model.dart';
import 'package:home_exercise/services/providers/notification_provider.dart';
import 'package:home_exercise/services/providers/order_provider.dart';

class Repository{
  static Future<List<OrderModel>> getOrders(String restaurantId) async =>  await OrderProvider.getOrders(restaurantId);
  static Future<List<OrderModel>> getAwaitings(String restaurantId) async =>  await OrderProvider.getAwaitings(restaurantId);
  static Future<List<NotificationModel>> getNotifications() async =>  await NotificationProvider.getNotifications();
}
