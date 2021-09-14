

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offside_yopal/app/domain/responses/reset_password_response.dart';
import 'package:offside_yopal/app/ui/global_widgets/button.dart';
import 'package:offside_yopal/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:offside_yopal/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:offside_yopal/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:offside_yopal/app/ui/pages/reset_password/controller/reset_password_controller.dart';
import 'package:offside_yopal/app/utils/email_validation.dart';
import 'package:flutter_meedu/screen_utils.dart';




    final resetPasswordProvider = SimpleProvider(
      (_) => ResetPasswordController(),
    );

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = context.mediaQueryPadding;
  final height = context.height - padding.top - padding.bottom;

    final isDarkMode = context.isDarkMode;
    return ProviderListener<ResetPasswordController>(
      provider: resetPasswordProvider,
      builder: (_,controller) => Scaffold(
        appBar: AppBar(),

        body: ListView(
          children: [
            SizedBox(
              height:height ,
              child: GestureDetector(
            onTap: ()=>FocusScope.of(context).unfocus(),
            child: Container(
              padding: const EdgeInsets.all(15),
            width:double.infinity,
            color: Colors.transparent,
            child: Align(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 360),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        AspectRatio(aspectRatio: 16/9,
                     child: SvgPicture.asset(
                       'assets/images/${isDarkMode? 'dark' : 'ligth'}/password.svg',
                     ),
                     ),
                      const SizedBox(height: 10,
                      ),
                   const  Center(
                       child:  Text("Restaurar Contraseña",
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         fontSize: 28,
                         fontWeight: FontWeight.bold,
                       ) ,
                       ),
                     ),
                     const SizedBox(height: 20,
                      ),
                    CustomInputField(
                      label: "Correo electronico",
                      onChanged: controller.onEmailChanged,
                      inputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 5,
                      ),
                      const Text(
                        "Ingrese su correo para recuperar la contraseña",
                        ),
                      const SizedBox(height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: RoundedButton(
                          onPressed: ()=> _submit(context),
                           text: "Enviar",
                           ),
                      ),
                         const SizedBox(height: 30,
                         ),
                  ],
                  ),
              ),
            ),
            ),
           ),
            )
          ],),
        ),
    );
  }
  void _submit(BuildContext context) async{
    final controller = resetPasswordProvider.read;
    if(isValidEmail(controller.email)){
        ProgressDialog.show(context);
        final response = await controller.submit();
        Navigator.pop(context);
        if(response == ResetPasswordResponse.ok){
          Dialogs.alert(
            context,
            title:"Bien",
            content: "Correo enviado",
             );
          }else{
            String errorMessaje ="";
            switch(response){
                
              case ResetPasswordResponse.networkRequestFailed:
                errorMessaje ="Sin conexion a internet";
                break;
              case ResetPasswordResponse.userDisable:
                errorMessaje ="Usuario deshabilitado";
                break;
              case ResetPasswordResponse.userNotFound:
                errorMessaje ="Usuario no encontrado";
                break;
              case ResetPasswordResponse.tooManyRequest:
                errorMessaje ="Demaciadas peticiones";
                break;
                case ResetPasswordResponse.invalidProvider:
                errorMessaje ="Este correo esta asociado a otro metodo de sesion";
                break;
              case ResetPasswordResponse.unknown:
              default:
                errorMessaje ="Error desconocido";
                break;
            }
            Dialogs.alert(
              context,
              title: "Error",
              content: errorMessaje,
            );
          }
    }else{
      Dialogs.alert(context,content: "Correo invalido");
    }
  }

}