import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/usecase.dart';
import 'package:spotify_app/data/models/auth/signin_user_request.dart';
import '../../../service_locator.dart';
import '../../repository/auth/auth.dart';

class SigninUseCase implements UseCase<Either,SigninUserRequest>{
  @override
  Future<Either> call({SigninUserRequest?params})async{
    return sl<AuthRepository>().signin(params!);
  }



}