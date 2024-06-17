/*
class LoginModel {
  final String name;
  final String email;
  final String password;
  final String phone;


  LoginModel(this.name, this.phone, {required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'name':name,
      'email': email,
      'password': password,
      'phone':phone,

    };
  }
}
*/


class LoginModel {
  final String? name;
  final String email;
  final String password;
  final String? phone;

  LoginModel({
    this.name,
    this.phone,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      if (name != null) 'name': name,
      'email': email,
      'password': password,
      if (phone != null) 'phone': phone,
    };
  }
}
