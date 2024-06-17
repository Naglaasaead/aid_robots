import 'dart:developer';

import 'package:aid_robot/features/auth_feature/presentation/screens/engineer_login_screen.dart';
import 'package:http/http.dart';

import '../../../features/auth_feature/data/models/user_model.dart';
import '../../error/exceptions.dart';
import '../../model/global_response_model.dart';
import '../../services/cache_service.dart';
import '../get_it_injection.dart';
import '../helper.dart';

class RemoteDataSourceCallHandler {
  RemoteDataSourceCallHandler();

  Future<dynamic> call(Response res,) async {
    if (res.statusCode == 200) {
      GlobalResponseModel response ;
      response = GlobalResponseModel.fromJson(res.body.toString());
      if(response.success==false){
        throw ServerException(response.msg??"unknown Error");
      }else{
        return response.data??{};
      }
    } else {
      throw ServerException("unknown error");
    }
  }

  Future<GlobalResponseModel> handleFormData(StreamedResponse res,) async {
    log(res.statusCode.toString(),name: "status code");
    String responseData = await res.stream.bytesToString();
    log(responseData,name: "response body");
    if (res.statusCode == 200) {
      final response = GlobalResponseModel.fromJson(responseData);
      if(response.authError==true){
        await getIt<CacheService>().clear();
        //todo handel login screen
        navigateTo(const EngineerLoginScreen(),removeAll: true);
        throw ServerException(response.msg ?? "unknown Error");
      }
      else if(response.success==false) {
        if(response.key=="needActive"){
          throw AuthException(response.msg??"unknown Error",user:UserModel.fromJson(response.data['user']));
        }
        throw ServerException(response.msg ?? "unknown Error");
      }
      return response;
    } else {
      throw ServerException("unknown error${res.statusCode}");
    }
  }
}
