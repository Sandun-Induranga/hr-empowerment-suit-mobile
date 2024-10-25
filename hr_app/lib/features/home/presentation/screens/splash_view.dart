import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/utils/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../../core/constants/color_codes.dart';
import '../../../authentication/bloc/auth_bloc.dart';
import '../../../authentication/bloc/auth_event.dart';
import '../../../authentication/presentation/screens/login_view.dart';
import '../../../home/presentation/screens/home_view.dart';
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
    _checkToken();
  }

  // Check token in local storage
  Future<void> _checkToken() async {
    final token = await SharedPreferencesService().getToken();

    if (token == null || _isTokenExpired(token)) {
      // Token is missing or expired, navigate to login
      _navigateToLogin();
    } else {
      // Token is valid, navigate to home
      final employeeId = _getEmployeeIdFromToken(token);
      _navigateToHome(employeeId);
    }
  }

  // Validate if the token is expired
  bool _isTokenExpired(String token) {
    try {
      final payloadBase64 = token.split('.')[1];
      final normalizedBase64 = base64.normalize(payloadBase64);
      final decodedPayload = utf8.decode(base64.decode(normalizedBase64));
      final payloadMap = json.decode(decodedPayload);

      final exp = payloadMap['exp'] as int?;
      if (exp == null) return true;

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isAfter(expiryDate);
    } catch (e) {
      // Handle decoding error
      print('Token decoding error: $e');
      return true;
    }
  }

  // Extract employee ID from token
  String? _getEmployeeIdFromToken(String token) {
    try {
      final payloadBase64 = token.split('.')[1];
      final normalizedBase64 = base64.normalize(payloadBase64);
      final decodedPayload = utf8.decode(base64.decode(normalizedBase64));
      final payloadMap = json.decode(decodedPayload);

      return payloadMap['userId'] as String?;
    } catch (e) {
      // Handle decoding error
      print('Token decoding error: $e');
      return null;
    }
  }

  // Navigate to LoginView
  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }

  // Navigate to HomeView with employee ID
  void _navigateToHome(String? employeeId) {
    context.read<AuthBloc>().add(SetEmployeeIdEvent(employeeId: employeeId ?? ''));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigationView(), // Adjust according to your HomeView constructor
      ),
    );
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
