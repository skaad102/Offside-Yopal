import 'package:flutter/material.dart';
import 'package:flutter_meedu/screen_utils.dart';

class LabelButton extends StatelessWidget {
  final String label,value;
  final VoidCallback? onPressed;
  const LabelButton({Key? key, 
  required this.label, 
  required this.value, 
   this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final iconColor = isDark?Colors.white30:Colors.black45;
    return MaterialButton(
      onPressed: (){
        if(onPressed!=null){
          onPressed!();
        }
      },
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),

      child: Row(
        children: [
            Expanded(
              child:Text(
                label,
             style: const TextStyle(fontWeight: FontWeight.w600,
             fontSize: 15),
             )
                ),
                 Row(
             mainAxisSize: MainAxisSize.min ,
             children: [
               Text(value,
               style: 
               const TextStyle(
                 fontSize: 15,
                 fontWeight: FontWeight.w400,
                 ),
                 ),
                 const SizedBox(width: 5),
               if(onPressed!=null)               
               Icon(Icons.chevron_right_rounded,
              size: 30,
              color:  iconColor ,
              )
               ]
           )
           ],
        ),
      );
    
  }
}