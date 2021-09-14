import 'package:firebase_auth/firebase_auth.dart';
import 'package:offside_yopal/app/domain/responses/reset_password_response.dart';
import 'package:offside_yopal/app/domain/responses/sign_in_response_.dart';

abstract class AuthenticationRepository{
  Future<User?> get user;
  Future<void> signOut();
  Future<SingInResponse> signInWithEmailAnfPassword(
    String email,
    String password,
  );

   Future<SingInResponse> signInWithGoogle();
   Future<SingInResponse> signInWithFacebook();

  Future<ResetPasswordResponse>sendResetPasswordLink(String email);

}




