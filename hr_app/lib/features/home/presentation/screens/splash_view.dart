import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/login/login_view.dart';

import '../../../../core/constants/color_codes.dart';
import '../../../navigation/bottom_navigator_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginView(),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCodes.primaryColor,
      body: Center(
        child: Icon(
          Icons.work,
          size: 100.r,
          color: ColorCodes.whiteColor,
        ),
      ),
    );
  }
}
