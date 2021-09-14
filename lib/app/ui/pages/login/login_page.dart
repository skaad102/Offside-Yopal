
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:offside_yopal/app/ui/colors.dart';
import 'package:offside_yopal/app/ui/global_controllers/session_controller.dart';
import 'package:offside_yopal/app/ui/pages/login/controller/login_controller.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/screen_utils.dart';

import 'widgets/login_form.dart';


final loginProvider = SimpleProvider(
  (_) => LoginController(sessionProvider.read),
);

class LoginPage extends StatelessWidget {
 const  LoginPage({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {

  context.height;
    return ProviderListener<LoginController>(
      provider: loginProvider,
      builder: (_,controller){
        return Scaffold(
      body: OrientationBuilder(
        builder:(_,orientation) {
          if(orientation == Orientation.portrait){
            return LoginForm();
          }
          return Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: primaryLigthColor,
                )
                ),
              Expanded(
                flex: 2,
                child: LoginForm(),
              )
            ],
          );
        } 
        ,)
    );
      },
    );


    
  }
}

