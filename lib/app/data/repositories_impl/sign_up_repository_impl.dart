

import 'package:firebase_auth/firebase_auth.dart';
import 'package:offside_yopal/app/domain/inputs/sign_up.dart';
import 'package:offside_yopal/app/domain/repositories/sing_up_repository.dart';
import 'package:offside_yopal/app/domain/responses/sign_up_response.dart';

class SignUpRepositoryImpl implements SignUpRepository{

  final FirebaseAuth _auth;

  SignUpRepositoryImpl(this._auth);

  @override
  Future<SignUpResponse> register(SignUpData data) async{
    
    try{
     final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: data.email,
       password: data.password,
       );
       userCredential.user!.updateDisplayName(
         "${data.name}${data.lastname}",
         );
         return SignUpResponse(null, userCredential.user);
    } on FirebaseAuthException catch(e){
      return SignUpResponse(parseStringToSignUpError(e.code),null);
    }

  }
  
}