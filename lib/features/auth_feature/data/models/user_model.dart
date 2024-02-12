import 'dart:convert';

import '../../../../app/error/exceptions.dart';

class UserModel {
  UserModel({
      this.id, 
      this.name, 
      this.profile,
      this.phone,
      this.token,
      this.otp,
  });

  factory UserModel.fromJson(String source) {
    try {
      return UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
    } catch (e) {
      throw DataParsingException(e.toString());
    }
  }
  UserModel.fromMap(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone_number'];
    token = json['token'];
    profile = json['profile'];
    email = json['email'];
    otp = json['otp'];
  }
  String? id;
  String? name;
  String? phone;
  String? token;
  String? profile;
  String? email;
  String? otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone_number'] = phone;
    map['token'] = token;
    map['profile'] = profile;
    map['email'] = email;
    map['otp'] = otp;
    return map;
  }

}