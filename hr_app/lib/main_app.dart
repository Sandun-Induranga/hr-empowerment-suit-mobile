import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/authentication/bloc/auth_provider.dart';
import 'package:hr_app/features/home/presentation/screens/splash_view.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            AuthProvider(),
          ],
          child: MaterialApp(
            // localizationsDelegates: const [
            //   AppLocalizations.delegate,
            //   CountryLocalizations.delegate,
            // ],            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            home: child,
            // routes: AppRoutes.routes,
            // theme: AppThemeData.lightThemeData(),
            // darkTheme: AppThemeData.darkThemeData(),
          ),
        );
      },
      child: const SplashView(),
    );
  }
}
