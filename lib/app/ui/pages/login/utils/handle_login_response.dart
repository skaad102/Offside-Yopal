
import 'package:flutter/cupertino.dart';
import 'package:offside_yopal/app/domain/responses/sign_in_response_.dart';
import 'package:offside_yopal/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:offside_yopal/app/ui/routes/routes.dart';
import 'package:flutter_meedu/router.dart' as router;

void handleLoginResponse(BuildContext context,SingInResponse response){
  if(response.error != null){
        String errorMessage = "";

        if(response.error !=SignInError.cancelled){
               switch (response.error) {
            case SignInError.networkRequestFailed:
              errorMessage= "Sin conexion a internet";
              break;
              case SignInError.userDisable:
              errorMessage= "Usuario deshabilitado";
              break;
              case SignInError.userNotFound:
              errorMessage= "Usuario no encontrado";
              break;
              case SignInError.wrongPassword:
              errorMessage= "contraseña incorrecta";
              break;
              case SignInError.tooManyRequest:
               errorMessage = "Muchas peticiones";
               break;
                case SignInError.invalidCredential:
               errorMessage = "Credenciales invalidas";
               break;
               case SignInError.accoutExistsWithDifferentCredential:
               errorMessage = response.providerId ?? "Metodo de autenticacion invalido";
               break;
               
              case SignInError.unknown:
              default:
              errorMessage= "Error desconocido";
              break;
            
          }
          Dialogs.alert(
            context,
            title: "Error",
            content : errorMessage,
          );
        }
         
      }else{
          router.pushReplacementNamed(
            Routes.HOME,
          );
}
}