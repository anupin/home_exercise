
///Manager model
class ManagerModel{

  ///Variables
  String id, name, surname, shift, restaurantId; ///Temporary string

  ///Contructure
  ManagerModel({
    this.id,
    this.name,
    this.surname,
    this.shift,
    this.restaurantId
  });

  ///Values to Json
  Map<String, dynamic> toJson() {
    Map<String, dynamic> rawMap = Map<String, dynamic>();

    rawMap["id"] = id;
    rawMap["name"] = name;
    rawMap["surname"] = surname;
    rawMap["shift"] = shift;
    rawMap["restaurantId"] = restaurantId;

    return rawMap;
  }

  ///Values from Json
  factory ManagerModel.fromJson(Map<String, dynamic> parsedJson) {

    ManagerModel managerModel = ManagerModel(
      id: parsedJson["id"],
      name: parsedJson["name"],
      surname: parsedJson["surname"],
      shift: parsedJson["shift"],
      restaurantId: parsedJson["restaurantId"],
    );

    return managerModel;
  }
}

