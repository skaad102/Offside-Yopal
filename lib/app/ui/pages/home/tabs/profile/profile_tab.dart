
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:offside_yopal/app/ui/global_controllers/session_controller.dart';
import 'package:offside_yopal/app/ui/global_controllers/theme_controller.dart';
import 'package:offside_yopal/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:offside_yopal/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:offside_yopal/app/ui/global_widgets/dialogs/shot_input_dialog.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/profile/widgets/label_button.dart';
import 'package:flutter_meedu/screen_utils.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:offside_yopal/app/ui/routes/routes.dart';

class ProfileTab extends ConsumerWidget{
  const ProfileTab({Key? key}) : super(key: key);
  void _updateDisplayName(BuildContext context)async{
    final sessionController = sessionProvider.read;
   final value = await showInputDialog(
     context,
      initialValue: sessionController.user!.displayName ?? ''
     );
   if(value!=null){
     ProgressDialog.show(context);
     final user = await sessionProvider.read.updateDisplayName(value);
     Navigator.pop(context);
     if(user==null){
       Dialogs.alert(
         context,
         title:"Error",
         content: "Revisa tu conexión a internet"
       );
     }
   }
  }
  @override
  Widget build(BuildContext context, watch) {
   final sessionController = watch(sessionProvider);
   final isDark = context.isDarkMode;
   final user = sessionController.user!;
   final displayName = user.displayName ?? '';
   final letter = displayName.isNotEmpty ? displayName[0]: "";

    return ListView(
     
      children:<Widget> [
        const SizedBox(
          height: 20),
        CircleAvatar(
          radius: 75,
          child: user.photoURL != null?
          ClipOval(
            
            child: Image.network(
              user.photoURL!,
              width: 150,
              height: 150,
              fit:BoxFit.contain,
            ),
          )
            
            
        //  backgroundImage: user.photoURL!= null? 
          //  NetworkImage(user.photoURL!,): null,
            : null,
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            displayName,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
              ),
              ),
            
            ),
         Center(child: Text(user.email ?? '')),
         const SizedBox(height: 50),
        // const Text("Datos del usuario"),
        LabelButton(
          label: "Nombre de usuario",
         value: displayName,
         onPressed: ()=>_updateDisplayName(context),
         ),
         LabelButton(
          label: "Correo electronico",
         value: user.email ?? '',
         ),
         LabelButton(
          label: "Correo verificado",
         value: user.emailVerified ? "SI" : "No",
         ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Modo Oscuro"),
                CupertinoSwitch(
                  value: isDark,
                  activeColor: isDark ? Colors.pinkAccent : Colors.blue,
                  onChanged: (_){
                    themeProvider.read.tooggle();
                  },
                  ),
              ],
            ),
          ),
            const SizedBox(height: 50),
            LabelButton(
          label: "Cerrar Sesion",
          value: "",
          onPressed: ()async{
            ProgressDialog.show(context);
            await  sessionProvider.read.signOut();
            router.pushNamedAndRemoveUntil(Routes.LOGIN);
          },
         ),


      ],
    )
      ;
  }
}


