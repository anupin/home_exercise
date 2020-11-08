
///Restaurant model
class NotificationModel{

  ///Variables
  String id, message, time; ///Temporary string

  ///Contructure
  NotificationModel({
    this.id,
    this.message,
    this.time
  });

  ///Values to Json
  Map<String, dynamic> toJson() {
    Map<String, dynamic> rawMap = Map<String, dynamic>();

    rawMap["id"] = id;
    rawMap["message"] = message;
    rawMap["time"] = time;

    return rawMap;
  }

  ///Values from Json
  factory NotificationModel.fromJson(Map<String, dynamic> parsedJson) {

    NotificationModel notificationModel = NotificationModel(
      id: parsedJson["id"],
      message: parsedJson["message"],
      time: parsedJson["time"],
    );

    return notificationModel;
  }
}

