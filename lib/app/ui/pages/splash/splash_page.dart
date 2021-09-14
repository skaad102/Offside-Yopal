

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:offside_yopal/app/ui/global_controllers/session_controller.dart';
import 'package:offside_yopal/app/ui/pages/splash/splash.controller.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/screen_utils.dart';

final splashProvider = SimpleProvider(
  (_)=>SplashController(sessionProvider.read),
 
  );

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<SplashController>(
      provider: splashProvider,
      onAfterFirstLayout: (_,__){
        if(!context.isTablet){
            SystemChrome.setPreferredOrientations(
              [
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
        }
      },
      onChange: (_, controller){
        final routeName = controller.routName;
        if(routeName !=null){
         router.pushReplacementNamed(routeName);
        }
        
      },
      builder: (_, __){
       return const Scaffold(
      body: Center(
        child:CircularProgressIndicator(),
        ),
    );
      }) ;
  }
}