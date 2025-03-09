import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/usecase.dart';
import 'package:spotify_app/data/repository/auth/auth_repository_impl.dart';

import '../../../data/models/auth/create_user_request.dart';
import '../../../service_locator.dart';
import '../../repository/auth/auth.dart';

class SignupUseCase implements UseCase<Either,CreateUserRequest>{
  @override
  Future<Either> call({CreateUserRequest ? params}) {
    return sl<AuthRepository>().signup(params!);
  }

}