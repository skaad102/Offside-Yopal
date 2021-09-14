
import 'package:offside_yopal/app/domain/inputs/sign_up.dart';
import 'package:offside_yopal/app/domain/responses/sign_up_response.dart';

abstract class SignUpRepository{

  Future<SignUpResponse> register(SignUpData data);

}

