import 'dart:convert';
import 'package:home_exercise/models/notification_model.dart';

///Order provider
class NotificationProvider{

  ///Get the orders
  static Future<List<NotificationModel>> getNotifications() async{

    /*List<DocumentSnapshot> rawOrders = (await References.notificationsCollection.getDocuments()).documents;
    List<NotificationsModel> notifications = new List();
    rawOrders.forEach((element) {
      NotificationsModel notification = NotificationsModel.fromJson(element.data);
      notifications.add(notification);
    });*/

    var jsonNotification1 = '{"id" : "01", "message" : "Lorem Ipsums", "time" : "8:32"}';
    var jsonNotification2 = '{"id" : "02", "message" : "Lorem Ipsums", "time" : "10:00"}';
    var jsonNotification3 = '{"id" : "03", "message" : "Lorem Ipsums", "time" : "13:12"}';
    var jsonNotification4 = '{"id" : "04", "message" : "Lorem Ipsums", "time" : "15:56"}';
    var jsonNotification5 = '{"id" : "05", "message" : "Lorem Ipsums", "time" : "16:24"}';
    var jsonNotification6 = '{"id" : "06", "message" : "Lorem Ipsums", "time" : "20:20"}';
    var jsonNotification7 = '{"id" : "07", "message" : "Lorem Ipsums", "time" : "21:26"}';
    var jsonNotification8 = '{"id" : "08", "message" : "Lorem Ipsums", "time" : "00:11"}';
    var jsonNotification9 = '{"id" : "09", "message" : "Lorem Ipsums", "time" : "4:04"}';
    var jsonNotification10 = '{"id" : "10", "message" : "Lorem Ipsums", "time" : "6:30"}';

    NotificationModel notification1 = NotificationModel.fromJson(jsonDecode(jsonNotification1));
    NotificationModel notification2 = NotificationModel.fromJson(jsonDecode(jsonNotification2));
    NotificationModel notification3 = NotificationModel.fromJson(jsonDecode(jsonNotification3));
    NotificationModel notification4 = NotificationModel.fromJson(jsonDecode(jsonNotification4));
    NotificationModel notification5 = NotificationModel.fromJson(jsonDecode(jsonNotification5));
    NotificationModel notification6 = NotificationModel.fromJson(jsonDecode(jsonNotification6));
    NotificationModel notification7 = NotificationModel.fromJson(jsonDecode(jsonNotification7));
    NotificationModel notification8 = NotificationModel.fromJson(jsonDecode(jsonNotification8));
    NotificationModel notification9 = NotificationModel.fromJson(jsonDecode(jsonNotification9));
    NotificationModel notification10 = NotificationModel.fromJson(jsonDecode(jsonNotification10));

    List<NotificationModel> notifications = new List();
    notifications.add(notification1);
    notifications.add(notification2);
    notifications.add(notification3);
    notifications.add(notification4);
    notifications.add(notification5);
    notifications.add(notification6);
    notifications.add(notification7);
    notifications.add(notification8);
    notifications.add(notification9);
    notifications.add(notification10);

    return notifications;
  }
}
