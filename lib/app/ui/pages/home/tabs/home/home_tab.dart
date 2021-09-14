

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:offside_yopal/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:offside_yopal/app/ui/routes/routes.dart';


class Hometab extends StatelessWidget {
  const Hometab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          
          children: [
                Text('Home',),
          ],
        ),
        );
  }
}