

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:offside_yopal/app/ui/global_controllers/session_controller.dart';
import 'package:offside_yopal/app/ui/global_widgets/button.dart';
import 'package:offside_yopal/app/ui/global_widgets/custom_input_field.dart';
import 'package:offside_yopal/app/ui/pages/register/controller/register_controller.dart';
import 'package:offside_yopal/app/ui/pages/register/controller/register_state.dart';
import 'package:offside_yopal/app/ui/pages/register/utils/send_register_form.dart';
import 'package:offside_yopal/app/utils/email_validation.dart';
import 'package:offside_yopal/app/utils/name_validation.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/screen_utils.dart';


final registerprovider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(sessionProvider.read),
);

class RegisterPage extends StatelessWidget {
const RegisterPage({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
          elevation: 0,
        );
    final padding = context.mediaQueryPadding;
  final height = context.height - padding.top - padding.bottom- appBar.preferredSize.height;
    return ProviderListener<RegisterController>(
      provider: registerprovider,
      builder: (_,controller){
        return Scaffold(
     
        appBar: appBar,
        body: ListView(
            children: [
              SizedBox(
                height: height,
                child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              padding: const EdgeInsets.all(15),
              child: Align(
                child: Form(
                 key: controller.formKey,
                  child:ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360
                    ),
                    child: Column(
                      mainAxisAlignment:
                      context.isTablet ?  MainAxisAlignment.center : MainAxisAlignment.end,
                      children: [
                          const Text("Formulario de registro",
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         fontSize: 28,
                         fontWeight: FontWeight.bold,
                       ),
                           ),
                           const SizedBox(
                          height: 20
                          ),
                        CustomInputField(
                          label: "Nombre",
                          onChanged: controller.onNameChanged,
                           validator: (text){                     
                            return isValidName(text!)?null:"caracter invalido";                   
                          }
                        ),
                        const SizedBox(
                          height: 15
                          ),
                    
                        CustomInputField(
                          label: "Apellidos",
                          onChanged:   controller.onLastNameChanged,
                          validator: (text){
                            return isValidName(text!)?null:"caracter invalido";                   
                          }
                        ),
                        const SizedBox(
                          height: 15
                          ),
                        CustomInputField(
                          label: "Correo Electronico",
                          inputType: TextInputType.emailAddress,
                          onChanged: controller.onEmailChanged,
                          validator: (text){
                            return isValidEmail(text!)?null:"correo invalido";                   
                          },
                        ),
                        const SizedBox(
                          height: 15
                          ),
                        CustomInputField(
                          label: "Contraseña",
                          onChanged: controller.onPasswordChanged,
                          ispassword: true,
                          validator: (text){
                            if(text!.trim().length>=6){
                              return null;
                            }
                            return "Contraseña invalida";
                          },
                        ),
                        const SizedBox(
                          height: 15
                          ),
                        Consumer(
                          builder: (_, watch, __){
                            watch(registerprovider.select(
                              (_) => _.password));
                           return CustomInputField(
                          label: "Verificar Contraseña",
                          onChanged: controller.onvPasswordChanged,
                          ispassword: true,
                          validator: (text){
                             if(controller.state.password!=text){
                              return "Las contraseñas no son iguales";
                            }
                            if(text!.trim().length>=6){
                              return null;
                            }
                           
                            return "Contraseña invalida";
                          },
                        );
                          },
                          ),
                           const SizedBox(height: 30,),
                            RoundedButton(
                              text: "Registrarse",
                              onPressed: () => sendRegisterForm(context),
                                
                               ),
                               if(!context.isTablet)
                             const SizedBox(height: 30),
                      ],
                      ),
                  ),
                  ),
              ),
            ),
          ),
              )
            ],
            ),
    );
      },
    );
  }
}