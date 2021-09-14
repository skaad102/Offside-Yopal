
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_meedu/screen_utils.dart';
import 'package:offside_yopal/app/ui/global_widgets/button.dart';
import 'package:offside_yopal/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:offside_yopal/app/ui/pages/login/login_page.dart';
import 'package:offside_yopal/app/ui/pages/login/utils/send_login_form.dart';
import 'package:offside_yopal/app/ui/pages/login/widgets/social_button.dart';
import 'package:offside_yopal/app/ui/routes/routes.dart';
import 'package:offside_yopal/app/utils/email_validation.dart';

class LoginForm extends StatelessWidget {
   LoginForm({
    Key? key,
  }) : super(key: key);

    final _controller = loginProvider.read;
  @override
  Widget build(BuildContext context) {
      final isDarkMode = context.isDarkMode;
  // MediaQuery.of(context).size;
  //  MediaQuery.of(context).padding.top.bottom;
  final padding = context.mediaQueryPadding;
  final height = context.height - padding.top - padding.bottom;

    return ListView(
    children: [
      SizedBox(
        height: height,
        child: GestureDetector(
      onTap: () =>FocusScope.of(context).unfocus(),
      child: Container(
        color: Colors.transparent,
        width:double.infinity,
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _controller.formKey,
          child: Align(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 360,
                ),
              child: Column(
                mainAxisAlignment: context.isTablet? MainAxisAlignment.center : MainAxisAlignment.end,
                children: [
                 AspectRatio(aspectRatio: 16/9,
                 child: SvgPicture.asset(
                   'assets/images/${isDarkMode? 'dark' : 'ligth'}/welcome.svg',
                 ),
                 ),
                 const SizedBox(height: 20),
                  CustomInputField(
                    label: "Correo electronico",
                    onChanged: _controller.onEmailChanged,
                    inputType: TextInputType.emailAddress,
                    validator: (text){
                      if(isValidEmail(text!)){
                        return null;
                      }
                        return "Correo invalido";
                    },
                    ),
                     const SizedBox(height: 20),
                     CustomInputField(
                       label: "Contraseña",
                       onChanged: _controller.onPasswordChanged,
                       ispassword: true,
                        validator: (text){
                          if(text!.trim().length>=6){
                              return null;
                          }
                          return "Contraseña invalida";
                        },
                         
                       
                       ),
                       const SizedBox(height: 20),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           TextButton(
                             onPressed: ()=> router.pushNamed(Routes.RESET_PASSWORD) ,
                              child: const Text("¿Olvido su contraseña?")
                              ),
                              const SizedBox(width: 10),
            
                            RoundedButton(text: "Ingresar",
                            onPressed: ()=> sendLoginForm(context),
                            ),
                          
                         ],
                       ),
                    const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "¿No tiene una cuenta?"
                      ),
                      TextButton(
                        onPressed: () =>router.pushNamed(
                          Routes.REGISTER,
                        ), 
                        child: const Text(
                          "Registrarse",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),)
                        ),
                    ],
                  ),
                  const SizedBox(height: 30,
                  ),
                  const Text("o inicia sesión con"),
                   const SizedBox(height: 10,
                  ),
                    const SocialButtons(),
                  if(!context.isTablet)
                     const SizedBox(height: 20),
                ],),
            ),
          ),
        ),
        ),
    ),
      )
    ],);
  }
}