import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/navigation/bottom_navigator_view.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          // localizationsDelegates: const [
          //   AppLocalizations.delegate,
          //   CountryLocalizations.delegate,
          // ],            supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          home: child,
          // routes: AppRoutes.routes,
          // theme: AppThemeData.lightThemeData(),
          // darkTheme: AppThemeData.darkThemeData(),
        );
      },
      child: const BottomNavigationView(),
    );
  }
}
