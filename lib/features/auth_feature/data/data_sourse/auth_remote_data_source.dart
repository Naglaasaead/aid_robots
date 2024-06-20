import '../../../../app/network/network_manager.dart';
import '../../../../app/utils/consts.dart';
import '../../../../app/utils/hanlders/remote_data_source_handler.dart';
import '../models/user_model.dart';

abstract class AuthDataSource{
  Future <UserModel> register(Map<String,String> map);
}

class AuthDataSourceImpl implements AuthDataSource{
  final NetworkManager networkManager;

  AuthDataSourceImpl(this.networkManager);
  @override
  Future<UserModel> register(Map<String, String> map) async {
    final res = await networkManager.request(
      body: map,
      endPoint: kSignUp,
    );
    final data =  await RemoteDataSourceCallHandler()(res);
    return UserModel.fromJson(data);
  }

}