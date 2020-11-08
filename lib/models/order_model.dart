
///Order model
class OrderModel{

  ///Variables
  String id, location, time, message, username, restaurantId; ///Temporary string
  bool awaiting;

  ///Contructure
  OrderModel({
    this.id,
    this.location,
    this.time,
    this.message,
    this.username,
    this.awaiting,
    this.restaurantId
  });

  ///Values to Json
  Map<String, dynamic> toJson() {
    Map<String, dynamic> rawMap = Map<String, dynamic>();

    rawMap["id"] = id;
    rawMap["location"] = location;
    rawMap["time"] = time;
    rawMap["message"] = message;
    rawMap["message"] = username;
    rawMap["awaiting"] = awaiting;
    rawMap["restaurantId"] = restaurantId;

    return rawMap;
  }

  ///Values from Json
  factory OrderModel.fromJson(Map<String, dynamic> parsedJson) {

    OrderModel orderModel = OrderModel(
      id: parsedJson["id"],
      location: parsedJson["location"],
      time: parsedJson["time"],
      message: parsedJson["message"],
      username: parsedJson["username"],
      awaiting: parsedJson["awaiting"],
      restaurantId: parsedJson["restaurantId"],
    );

    return orderModel;
  }
}

