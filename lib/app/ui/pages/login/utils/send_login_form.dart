
import 'package:flutter/material.dart';
import 'package:offside_yopal/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:offside_yopal/app/ui/pages/login/login_page.dart' show loginProvider;
import 'package:flutter_meedu/router.dart' as router;
import 'package:offside_yopal/app/ui/pages/login/utils/handle_login_response.dart';


Future<void> sendLoginForm(BuildContext context) async{
    final controller = loginProvider.read;
    final isValidForm = controller.formKey.currentState!.validate();
    if (isValidForm){
      ProgressDialog.show(context);
      final response =  await  controller.signInWithEmailAndPassword();
      router.pop();
      handleLoginResponse(context, response);      }
    }
