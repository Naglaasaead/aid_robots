import 'dart:convert';

import '../../features/auth_feature/data/models/user_model.dart';

class Chat_Model {
  String id;
  List<UserModel> users = [];
  List chat = [];
  List user_id = [];

  Chat_Model({
    required this.id,
    required this.users,
    required this.chat,
    required this.user_id,
  });

  factory Chat_Model.fromJson(Map<String, dynamic> json) {
    return Chat_Model(
      id: json['id'],
      users: List<UserModel>.from(json['users'].map((user) => UserModel.fromJson(user))),
      chat: List.from(json['chat']),
      user_id: List.from(json['user_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'users': this.users.map((user) => user.toJson()).toList(),
      'chat': this.chat,
      'user_id': this.user_id,
    };
  }
}
