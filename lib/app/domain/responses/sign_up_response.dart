
import 'package:firebase_auth/firebase_auth.dart';

class SignUpResponse{
  final SingUpError? error;
  final User? user;

  SignUpResponse(this.error, this.user); 
}

parseStringToSignUpError(String text){
  switch(text){
     case "too-many-request":
        return SingUpError.tooManyRequest;
    case "email-already-in-use":
    return SingUpError.emailAlreadyInUse;
     case "weak-password":
    return SingUpError.weakPassword;
    case "network-request-failed":
        return SingUpError.networkRequestFailed;
    default:
    return SingUpError.unknown;
  }
}

enum SingUpError{
  tooManyRequest,
  emailAlreadyInUse,
weakPassword,
networkRequestFailed,
 unknown,
 }