

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:offside_yopal/app/domain/repositories/accout_repository.dart';
import 'package:offside_yopal/app/domain/repositories/autenticacion_repositorio.dart';

class SessionController extends SimpleNotifier{

  User? _user;
  User? get user => _user;

  final AuthenticationRepository _auth = Get.i.find();
  final AccountRepository _accout = Get.i.find();

  void setUser(User user){
    _user = user;
    notify();
  }

  Future<User?> updateDisplayName(String value)async{
   final user = await _accout.updateDisplayName(value);
   if(user!=null){
     _user = user;
     notify();
   }
   return user;
  }

  Future <void> signOut() async{
   await _auth.signOut();
   _user = null;
  }
}
final sessionProvider = SimpleProvider(
  (_) => SessionController(),
  autoDispose: false,
);