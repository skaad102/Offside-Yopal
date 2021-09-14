
import 'package:offside_yopal/app/domain/repositories/autenticacion_repositorio.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:offside_yopal/app/ui/global_controllers/session_controller.dart';
import 'package:offside_yopal/app/ui/routes/routes.dart';

class SplashController extends SimpleNotifier{
  final SessionController _sessionController;
   final AuthenticationRepository _authRepository = Get.i.find();

   String? _routeName;
   String? get routName => _routeName;

  SplashController(this._sessionController){
  
    _init();
  }

   void _init() async{
    final user = await _authRepository.user;
    if(user!=null){
      _routeName = Routes.HOME;
      _sessionController.setUser(user);
    } else {
        _routeName = Routes.LOGIN;
    }
    notify();
   }
    
    

}