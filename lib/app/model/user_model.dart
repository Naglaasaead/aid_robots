/*
class UserModel{
  String name,number,image,email,pass ;

  UserModel({required this.name, required this.number, required this.image,required this.email,required this.pass});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      number: json["number"],
      image: json["image"],
      email: json["email"],
      pass: json["pass"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "number": this.number,
      "image": this.image,
      "email": this.email,
      "pass": this.pass,
    };
  }

//
}*/


class UserModel {
final String email;
final String name;
final String phoneNumber;
final String uId;

UserModel({
  required this.email,
  required this.name,
  required this.phoneNumber,
  required this.uId,
});
factory UserModel.fromJson(Map<String, dynamic> json) {
return UserModel(
email: json['email'],
name: json['name'],
phoneNumber: json['phoneNumber'],
uId: json['uId'],
);
}
Map<String,dynamic>toJson(){
return {
'email':email,
'name':name,
'phoneNumber':phoneNumber,
'uId':uId,
};
}
}