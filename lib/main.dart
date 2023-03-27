import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal/pages/auth/login.dart';
import 'package:minimal/pages/auth/signup.dart';
import 'package:minimal/pages/intro_page.dart';
import 'package:minimal/routes.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'pages/home_page.dart';
import 'pages/taps/profile_page.dart';
import 'utils/styles/theme_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.ensureScreenSize();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(2400, 812),
      builder: (context, child) => MaterialApp(
        theme: AppTheme.lighTheme,
        builder: (context, child) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, child!),
            maxWidth: 2400,
            minWidth: 450,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
            background: Container(color: const Color(0xFFF5F5F5))),
        initialRoute: Routes.intro,
        onGenerateRoute: (RouteSettings settings) {
          return Routes.fadeThrough(settings, (context) {
            switch (settings.name) {
              case Routes.intro:
                return const IntroPage();
              case Routes.home:
                return const HomeScreen();
              case Routes.profile:
                return const ProfilePage();
              case Routes.login:
                return const LoginPage();
              case Routes.signup:
                return const SignupPage();
              default:
                return const SizedBox.shrink();
            }
          });
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
