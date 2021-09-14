
import 'package:flutter/cupertino.dart';
import 'package:offside_yopal/app/domain/responses/sign_up_response.dart';
import 'package:offside_yopal/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:offside_yopal/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:offside_yopal/app/ui/pages/register/widgets/register_page.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:offside_yopal/app/ui/routes/routes.dart';

Future<void> sendRegisterForm(BuildContext context) async{
 final controller =  registerprovider.read;
 final isValidForm = controller.formKey.currentState!.validate();

 if(isValidForm) {
   ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();

    if(response.error != null){
      late  String content ;
      switch (response.error){
          case SingUpError.emailAlreadyInUse:
          content= "Este Correo ya esta en uso";
          break;
          case SingUpError.weakPassword:
          content= "Contraseña insegura";
          break;
          case SingUpError.networkRequestFailed:
          content = "Sin conexion a internet";
          break;
          case SingUpError.tooManyRequest:
          content = "Muchas peticiones";
          break;

          default:
          content= "Error desconocido";
          break;
      }
      
      Dialogs.alert(
        context,
        title: "Error",
        content: content,
        );
    }else{
      router.pushNamedAndRemoveUntil(
        Routes.HOME,
        );
    }
 }else{
   Dialogs.alert(
     context,
     title: "Error",
     content: "Invalid fields"
     );
 }
 }