


enum ResetPasswordResponse{
     ok,
     networkRequestFailed,
      userDisable,
      userNotFound,
      unknown,
      tooManyRequest,
      invalidProvider,
  }

  ResetPasswordResponse StringToResetPasswordResponse(String code){
    switch(code){
     case "internal-error":
     return ResetPasswordResponse.tooManyRequest;
      case "user-not-found":
     return ResetPasswordResponse.userNotFound;
      case "user-disabled":
     return ResetPasswordResponse.userDisable;
      case "network-request-failed":
     return ResetPasswordResponse.networkRequestFailed;
     case "account-exists-with-different-credential":
     return ResetPasswordResponse.invalidProvider;
     default:
     return ResetPasswordResponse.unknown;
    }
  }