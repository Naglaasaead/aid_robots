
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../app/error/failures.dart';
import '../../../../../app/usecase/usecase.dart';
import '../../data/models/user_model.dart';
import '../repo/auth_repo.dart';

class RegisterUseCase implements UseCase<UserModel, RegisterUseCaseParams> {
  final AuthRepo repository;

  RegisterUseCase( {required this.repository});

  @override
  Future<Either<Failure, UserModel>> call(RegisterUseCaseParams params) async{
    return await repository.register(params.toMap());
  }

}

class RegisterUseCaseParams {
  /*
  	"name": "Naglaa",
	"phone": "01016738844",
	"email": "naglaa23@gmail.com",
	"password": "123456",
   */
  final String email;
  final String password;
  final String phone;
  final String name;
  RegisterUseCaseParams(
      {
        required this.email,
        required this.password,
        required this.phone,
        required this.name,
        // required this.deviceId,
        // required this.deviceType,
      });

  Map<String, String> toMap() {
    final map = {
      "email": email,
      "password": password,
      "phone": phone,
      "name": name,
      // "device_id": deviceId,
      // "device_type": deviceType,
    };
    return map;
  }
}





/*Future<void> loginUser(String email, String password) async {
  final url = Uri.parse('http://your-nodejs-server-address/login');
  var http;
  final response = await http.post(
    url,
    body: json.encode({
      'email': email,
      'password': password,
    }),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    // Login successful
    print('Login successful!');
    print('Response: ${response.body}');
    // You can handle the response here, such as saving user data or navigating to another screen.
  } else {
    // Login failed
    print('Login failed: ${response.body}');
    // You can show an error message to the user.
  }
}*/





Future<void> loginUser(String email, String password) async {
  try {
    final dio = Dio();
    final url = 'http://192.168.110.166:3000/';

    final response = await dio.post(
      url,
      data: {
        'email': email,
        'password': password,
      },
      options: Options(
        contentType: 'application/json',
      ),
    );

    if (response.statusCode == 200) {
      // Login successful
      print('Login successful!');
      print('Response: ${response.data}');

    } else {
      // Login failed
      print('Login failed: ${response.data}');

    }
  } catch (e) {

    print('Error: $e');
  }
}

