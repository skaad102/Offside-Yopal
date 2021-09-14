

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const RoundedButton({
    Key? key,
     this.onPressed, 
     required this.text
     }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
   style: ButtonStyle(
           textStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 16,
              )
           ),
           elevation: MaterialStateProperty.all(8) ,
                               shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
            ),
            ),
        onPressed: onPressed,
        child:  Text(text),
  );
  }
}