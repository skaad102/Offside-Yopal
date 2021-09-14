

import 'package:flutter/widgets.dart' show FormState,GlobalKey;
import 'package:flutter_meedu/meedu.dart';
import 'package:offside_yopal/app/domain/repositories/autenticacion_repositorio.dart';
import 'package:offside_yopal/app/domain/responses/sign_in_response_.dart';
import 'package:offside_yopal/app/ui/global_controllers/session_controller.dart';

class LoginController extends SimpleNotifier{
  final SessionController _sessionController;
  String _email ='', _password ='';
  final _authenticationRepository = Get.i.find<AuthenticationRepository>();
  final GlobalKey<FormState> formKey = GlobalKey();

  LoginController(this._sessionController);

  void onEmailChanged(String text){
    _email = text;
  }

  void onPasswordChanged(String text){
    _password = text;
  }

  Future<SingInResponse>signInWithEmailAndPassword()async{
      final response = await _authenticationRepository.signInWithEmailAnfPassword(
        _email, _password
        );

          if(response.error==null){
              _sessionController.setUser(response.user!);
          }
        return response;
  }

  Future<SingInResponse>signInWithGoogle()async{
   final response = await _authenticationRepository.signInWithGoogle();
   if(response.error == null){
     _sessionController.setUser(response.user!);
   }
   return response;
  }

    Future<SingInResponse>signInWithFacebook()async{
   final response = await _authenticationRepository.signInWithFacebook();
   if(response.error == null){
     _sessionController.setUser(response.user!);
   }
   return response;
  }
}