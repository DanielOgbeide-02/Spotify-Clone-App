import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/models/auth/create_user_request.dart';
import 'package:spotify_app/data/models/auth/signin_user_request.dart';
import 'package:spotify_app/data/sources/auth/auth_firebase_service.dart';

import '../../../domain/repository/auth/auth.dart';
import '../../../service_locator.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either> signin(SigninUserRequest signinUserRequest) async{
    return await sl<AuthFirebaseService>().signin(signinUserRequest);
  }

  @override
  Future<Either> signup(CreateUserRequest createUserRequest) async{
    return await sl<AuthFirebaseService>().signup(createUserRequest);
  }

}