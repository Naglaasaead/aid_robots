import 'package:dartz/dartz.dart';

import '../../../../app/error/failures.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepo{
  Future<Either<Failure, UserModel>>register(Map<String,String> map);
}