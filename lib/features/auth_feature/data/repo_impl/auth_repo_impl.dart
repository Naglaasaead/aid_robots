import 'dart:convert';

import 'package:aid_robot/app/error/failures.dart';
import 'package:aid_robot/features/auth_feature/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../app/network/network_info.dart';
import '../../../../app/services/cache_service.dart';
import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/utils/hanlders/repo_impl_callhandler.dart';
import '../../domain/repo/auth_repo.dart';
import '../data_sourse/auth_remote_data_source.dart';

class AuthRepoImpl extends AuthRepo{
  final AuthDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepoImpl(this.authRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, UserModel>> register(Map<String, String> map) async {
    return await RepoImplCallHandler<UserModel>(networkInfo)(() async {
      final result= await authRemoteDataSource.register(map);
      await getIt<CacheService>().setUserToken(token: result.token??"null");
      await getIt<CacheService>().saveUserData(encodedUser: json.encode(result.toJson()));
      return  result;
    });
  }
}