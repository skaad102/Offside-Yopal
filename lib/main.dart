// @dart=2.9
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:offside_yopal/app/inject_dependencies.dart';
import 'app/my_app.dart';
import 'package:flutter_meedu/router.dart' as router; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await injectDependencies();
  router.setDefaultTransition(router.Transition.fadeIn);
  runApp(const MyApp());
}
