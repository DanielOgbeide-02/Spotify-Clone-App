import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/common/helpers/is_dark_mode.dart';
import 'package:spotify_app/common/widgets/appbar/app_bar.dart';
import 'package:spotify_app/common/widgets/button/basic_app_button.dart';
import 'package:spotify_app/core/configs/Theme/app_colors.dart';
import 'package:spotify_app/data/models/auth/signin_user_request.dart';
import 'package:spotify_app/domain/usecases/auth/signin.dart';
import 'package:spotify_app/presentation/auth/pages/signup.dart';

import '../../../core/configs/assets/app_vectors.dart';
import '../../../service_locator.dart';
import '../../home/pages/home.dart';

class SigninPage extends StatelessWidget {
   SigninPage({super.key});
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signupText(context),
      appBar:
      BasicAppbar(
        title: SvgPicture.asset(
            height: 40,
            width: 40,
            AppVectors.logo
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: 60,
            left: 30,
            right: 30
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _signinText(),
              const SizedBox(
                height: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _supportText(context),
                  TextButton(
                      onPressed: (){},
                      child: Text(
                        'Click Here',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w400,
                            fontSize: 15
                        ),
                      )
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              _emailOrUserNameField(context),
              const SizedBox(
                height: 20,
              ),
              _passwordField(context),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  _recoveryPassword(context),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BasicAppButton(onPressed: () async{
                var result = await sl<SigninUseCase>().call(
                    params: SigninUserRequest(
                        email: _email.text.toString().trim(),
                        password: _password.text.toString().trim()
                    )
                );
                result.fold(
                        (l){
                      var snackbar = SnackBar(content: Text(l, style: TextStyle(
                        color: Colors.black
                      ),));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      print(l);
                    },//l is for failed signup
                (r){
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context)=> const HomePage()),
                          (route)=>false
                  );
                        }//for successful singin
                );
              },
                  title: 'Sign In'),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                      AppVectors.horizontalDivider
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Text(
                      'Or',
                      style: TextStyle(
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                      AppVectors.horizontalDivider
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SvgPicture.asset(
                        AppVectors.googleIcon,
                        width: 28,
                        height: 28,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 55,
                  ),
                  GestureDetector(
                    child: SvgPicture.asset(
                      AppVectors.appleIcon,
                      width: 29,
                      height: 36,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signinText(){
    return const Text(
      textAlign: TextAlign.center,
      'Sign In',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25
      ),
    );
  }

  Widget _supportText(BuildContext context){
    return Text(
      textAlign: TextAlign.center,
      'If You Need Any Support',
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: context.isDarkMode?AppColors.grey:Colors.black
      ),
    );
  }

  Widget _recoveryPassword(BuildContext context){
   return TextButton(
        onPressed: (){},
        child: Text(
          'Recovery Password',
          style: TextStyle(
              color: context.isDarkMode?AppColors.grey:Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 15
          ),
        )
    );
  }

  Widget _signupText(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            'Not A Member?',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: context.isDarkMode?AppColors.grey:Colors.black
            ),
          ),
          TextButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  SignupPage()));
              },
              child: const Text(
                'Register Now',
                style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w400,
                    fontSize: 15
                ),
              )
          )
        ],
      ),
    );
  }



  Widget _emailOrUserNameField(context){
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
          hintText: 'Enter Username Or Email'
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _passwordField(context){
    return TextField(
      controller: _password,
      decoration: const InputDecoration(
          hintText: 'Password'
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }
}
