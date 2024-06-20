import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../model/filter_model.dart';
import '../network/remot/dio_helper.dart';
import '../network/remot/end_point.dart';

/*


class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/', // Replace with your API base URL
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return await dio.post(url, data: data);
  }
}



class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(LoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password
      },
    ).then((response) {
      print("Login response: ${response.data}");
      // Check if the response is successful and contains the expected data
     emit(SuccessState());
    }).catchError((error) {
      print("Login error: $error");
      emit(ErrorState(error.toString()));
    });
  }
}

// cubit_state.dart
// part of 'login_cubit.dart';

@immutable
abstract class LoginStates {}

class InitialState extends LoginStates {}
class LoadingState extends LoginStates {}
class SuccessState extends LoginStates {}
class ErrorState extends LoginStates {
  final String error;
  ErrorState(this.error);
}
*/



class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/', // Replace with your API base URL
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await dio.post(url, data: data);
    } catch (error) {
      print("Dio error: $error");
      rethrow;
    }
  }
}

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    final loginData = LoginModel(email: email, password: password);

    emit(LoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: loginData.toMap(),
    ).then((response) {
      print("Login response: ${response.data}");
      if (response.data['status']) {
        emit(SuccessState());
      } else {
        emit(ErrorState(response.data['message']));
      }
    }).catchError((error) {
      print("Login error: $error");
      emit(ErrorState(error.toString()));
    });
  }



}


// cubit_state.dart
// part of 'login_cubit.dart';

@immutable
abstract class LoginStates {}

class InitialState extends LoginStates {}
class LoadingState extends LoginStates {}
class SuccessState extends LoginStates {}
class ErrorState extends LoginStates {
  final String error;
  ErrorState(this.error);

}

//Register Cubit
class RegisterCubit extends Cubit<RegisterStae> {
  RegisterCubit() : super(InitialStateRegister());

  static RegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({required String name, required String phone, required String email, required String password}) {
    final registerData = LoginModel(name: name, phone: phone, email: email, password: password);

    emit(LoadingStateRegister());
    DioHelper.postData(
      url: REGISTER,
      data: registerData.toMap(),
    ).then((response) {
      print("Register response: ${response.data}");
      if (response.data['status']) {
        emit(SuccessStateRegister());
      } else {
        emit(ErrorStateRegister(response.data['message']));
      }
    }).catchError((error) {
      print("Register error: $error");
      emit(ErrorStateRegister(error.toString()));
    });
  }


}




// cubit_state.dart
// part of 'login_cubit.dart';

@immutable
abstract class RegisterStae {}

class InitialStateRegister extends RegisterStae {}
class LoadingStateRegister extends RegisterStae {}
class SuccessStateRegister extends RegisterStae {}
class ErrorStateRegister extends RegisterStae {
  final String error;
  ErrorStateRegister(this.error);

}

@immutable
abstract class ForgetPasswordState {}

class InitialStateForgetPassword extends ForgetPasswordState {}
class LoadingStateForgetPassword extends ForgetPasswordState {}
class SuccessStateForgetPassword extends ForgetPasswordState {}
class ErrorStateForgetPassword extends ForgetPasswordState {
  final String error;
  ErrorStateForgetPassword(this.error);

}


