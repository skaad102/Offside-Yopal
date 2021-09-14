

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:offside_yopal/app/domain/repositories/preferences_respository.dart';

import '../colors.dart';

class ThemeController extends SimpleNotifier{

  late ThemeMode _mode ;

  ThemeController(){ 
    _mode = _preferences.isDarkmode?ThemeMode.dark : ThemeMode.light;
  }
  final PreferencesRepository _preferences = Get.i.find();

  ThemeMode get mode => _mode ;
  bool get isDark => _mode == ThemeMode.dark;

    TextTheme get _textTheme{
        return GoogleFonts.robotoCondensedTextTheme();
    }

  ThemeData get lightTheme{
    return ThemeData.light().copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme:const AppBarTheme(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color :primaryLigthColor,
        )
      ),   
       textTheme:_textTheme ,
      primaryColorLight: primaryLigthColor,
      colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.light,
          primarySwatch:  MaterialColor( primaryLigthColor.value, swatch),
        ),
        
        inputDecorationTheme:InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryLigthColor.withOpacity(0.5),
            )
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black26,
        ),
          )
        ),
    );
  }

  ThemeData get darkTheme{
    return ThemeData.dark().copyWith(
      appBarTheme:const AppBarTheme(
        brightness: Brightness.dark,
        backgroundColor: Color(0xff1c313a),  
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        )  
      ),
       textTheme:_textTheme
          .merge(
            ThemeData.dark().textTheme,
          )
          .apply(
            fontFamily: _textTheme.bodyText1!.fontFamily,
          )
          ,
      scaffoldBackgroundColor: const Color(0xff102027),
        primaryColorDark: primaryDarkColor,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryDarkColor,
        ),
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primarySwatch:  MaterialColor( primaryDarkColor.value, swatch),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryDarkColor,
            )
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white54,
        ),
          )
        ),

      );
}

  void tooggle(){
    if (_mode == ThemeMode.light){
      _mode = ThemeMode.dark;
      _preferences.darkMode(true);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }else {
      _mode = ThemeMode.light;
      _preferences.darkMode(false);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notify();
}
}



final themeProvider = SimpleProvider(
  (_) => ThemeController(),
  autoDispose: false,
);
  