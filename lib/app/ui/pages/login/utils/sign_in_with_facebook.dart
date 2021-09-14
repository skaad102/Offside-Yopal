

import 'package:flutter/material.dart';
import 'package:offside_yopal/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:offside_yopal/app/ui/pages/login/login_page.dart';
import 'package:offside_yopal/app/ui/pages/login/utils/handle_login_response.dart';

void signInWithFacebook(BuildContext context) async{
  ProgressDialog.show(context);
  final controller = loginProvider.read;
  final response = await controller.signInWithFacebook();
  Navigator.pop(context);
  handleLoginResponse(context, response);
  
}