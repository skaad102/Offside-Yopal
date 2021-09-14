import 'package:flutter_meedu/meedu.dart';
import 'package:offside_yopal/app/domain/repositories/autenticacion_repositorio.dart';
import 'package:offside_yopal/app/domain/responses/reset_password_response.dart';

class ResetPasswordController extends SimpleNotifier{

  String _email ='';
  String get email =>_email;

  final _authenticationRepository = Get.i.find<AuthenticationRepository>();

  void onEmailChanged(String text){
    _email = text;
  }


  Future<ResetPasswordResponse> submit(){
    return _authenticationRepository.sendResetPasswordLink(email);
  }
}