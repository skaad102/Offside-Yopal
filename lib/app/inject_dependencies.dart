import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:offside_yopal/app/data/repositories_impl/account_repository_impl.dart';
import 'package:offside_yopal/app/data/repositories_impl/autenticacion_repositorio_impl.dart';
import 'package:offside_yopal/app/data/repositories_impl/preferences_repository_impl.dart';
import 'package:offside_yopal/app/data/repositories_impl/sign_up_repository_impl.dart';
import 'package:offside_yopal/app/domain/repositories/accout_repository.dart';
import 'package:offside_yopal/app/domain/repositories/autenticacion_repositorio.dart';
import 'package:offside_yopal/app/domain/repositories/preferences_respository.dart';
import 'package:offside_yopal/app/domain/repositories/sing_up_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> injectDependencies()async{

  final preferences =  await  SharedPreferences.getInstance();

    Get.i.lazyPut<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(
        firebaseAuth: FirebaseAuth.instance,
        googleSignIn: GoogleSignIn(),
        facebookAuth: FacebookAuth.instance,
      ),
    );

     Get.i.lazyPut<SignUpRepository>(
      () => SignUpRepositoryImpl(FirebaseAuth.instance),
    );
    Get.i.lazyPut<AccountRepository>(
      () => AccountRepositoryImpl(
        FirebaseAuth.instance,
      ),
      );

      Get.i.lazyPut<PreferencesRepository>(
        () => PreferencesRepositoryImpl(preferences),
        );
}