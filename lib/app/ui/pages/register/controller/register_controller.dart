

import 'package:flutter/widgets.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:offside_yopal/app/domain/inputs/sign_up.dart';
import 'package:offside_yopal/app/domain/repositories/sing_up_repository.dart';
import 'package:offside_yopal/app/domain/responses/sign_up_response.dart';
import 'package:offside_yopal/app/ui/global_controllers/session_controller.dart';
import 'package:offside_yopal/app/ui/pages/register/controller/register_state.dart';

class RegisterController extends StateNotifier<RegisterState>{
final SessionController _sessionController;
  RegisterController(this._sessionController) : super(RegisterState.initialState);
final GlobalKey<FormState> formKey = GlobalKey();
final SignUpRepository _signUpRepository = Get.i.find();


  Future<SignUpResponse> submit()async{
      final response = await _signUpRepository.register(
        SignUpData(
          email: state.email, 
          lastname: state.lastname,
          name: state.name, 
          password: state.password
          ),
          );

          if(response.error==null){
            _sessionController.setUser(response.user!);
          }

          return response;
    }

    void onNameChanged(String text){
      state = state.copyWith(name : text);
    }
    void onLastNameChanged(String text){
      state = state.copyWith(lastname : text);
    }
    void onEmailChanged(String text){
      state = state.copyWith(email : text);
    }
    void onPasswordChanged(String text){
      state = state.copyWith(password : text);
    }
    void onvPasswordChanged(String text){
      state = state.copyWith(vPassword : text);
    }

}