import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart' show BuildContext, Widget;
import 'package:offside_yopal/app/ui/pages/calendar/add_cita.dart';
import 'package:offside_yopal/app/ui/pages/calendar/calendar_page.dart';
import 'package:offside_yopal/app/ui/pages/calendar/custom_calendario.dart';
import 'package:offside_yopal/app/ui/pages/home/home_pages.dart';
import 'package:offside_yopal/app/ui/pages/login/login_page.dart';
import 'package:offside_yopal/app/ui/pages/register/widgets/register_page.dart';
import 'package:offside_yopal/app/ui/pages/reset_password/reset_password_page.dart';
import 'package:offside_yopal/app/ui/pages/splash/splash_page.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.SPLASH: (_) => const SplashPage(),
      Routes.LOGIN: (_) => const LoginPage(),
      Routes.HOME: (_) => const HomePage(),
      Routes.REGISTER: (_) => const RegisterPage(),
      Routes.RESET_PASSWORD: (_) => const ResetPasswordPage(),
      Routes.CALENDAR: (_) => const CalendarPage(),
      Routes.CALENDARIO: (_) => const CustomCalendario(),
      Routes.ADD_CITA: (_) => const AddCita(),
    };
