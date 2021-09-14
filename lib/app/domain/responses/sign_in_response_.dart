

 import 'package:firebase_auth/firebase_auth.dart';

class SingInResponse{
   final SignInError? error;
   final User? user;
   final String? providerId;

   SingInResponse({
    required this.error,
    required this.user, 
    required this.providerId
      }
      );
 }

  enum SignInError{
     cancelled,
     tooManyRequest,
      networkRequestFailed,
      userDisable,
      userNotFound,
      wrongPassword,
      unknown,
      accoutExistsWithDifferentCredential,
      invalidCredential,
      //tooManyRequest
  }

  SingInResponse getSignInError(FirebaseAuthException e){
    late SignInError error;
    switch(e.code){
      case "too-many-request":
        error = SignInError.tooManyRequest;
        break;
        case "user-disabled":
        error = SignInError.userDisable;
        break;
        case "user-not-found":
        error = SignInError.userNotFound;
        break;
        case "network-request-failed":
        error = SignInError.networkRequestFailed;
        break;
        case "wrong-password":
        error = SignInError.wrongPassword;
        break;
        case "invalid-credential":
        error = SignInError.invalidCredential;
        break;
        case "accout-exists-with-different-credential":
        error = SignInError.accoutExistsWithDifferentCredential;
        break;
        default:
        error = SignInError.unknown;
    }
    return SingInResponse(
      error: error,
      user: null,providerId:
       e.credential?.providerId);
  }