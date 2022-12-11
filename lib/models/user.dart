import 'package:zabihtk/models/city.dart';

class User {
    String userId;
    String userName;
    String userEmail;
    String userPhone;
    String userType;
    String userAdress;
    int userNumber;
    City userCity;

    User({
        this.userId,
        this.userName,
        this.userEmail,
        this.userPhone,
        this.userType,
        this.userCity,
        this.userAdress,
        this.userNumber,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userPhone: json["user_phone"],
        userType: json["user_type"],
        userAdress: json["user_adress"],
        userNumber: json["user_number"],
        userCity: City.fromJson(json["user_city"]),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_email": userEmail,
        "user_phone": userPhone,
        "user_type": userType,
        "user_adress": userAdress,
        "user_number": userNumber,
        "user_city": userCity.toJson(),
    };
}
