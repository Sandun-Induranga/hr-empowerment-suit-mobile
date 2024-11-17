// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hr_app/core/constants/app_paddings.dart';
// import 'package:hr_app/core/constants/color_codes.dart';
// import 'package:hr_app/core/widgets/common_page_widgets/common_page_boiler_plate.dart';
// import 'package:hr_app/core/widgets/gap_widgets/vertical_gap_consistent.dart';
//
// import '../../../../core/widgets/common_page_widgets/common_app_bar.dart';
// import '../../../navigation/bottom_navigator_view.dart';
//
// class LoginView extends StatelessWidget {
//   const LoginView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController usernameController = TextEditingController();
//     final TextEditingController passwordController = TextEditingController();
//
//     void login() {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const BottomNavigationView(),
//         ),
//       );
//     }
//
//     return CommonPageBoilerPlate(
//       isNeedToApplySafeArea: false,
//       appBarPreferredSize: 80.h,
//       commonAppBar: CommonAppBar(
//         titleWidget: const Text('Login', style: TextStyle(fontSize: 24)),
//         actionWidget: Icon(
//           Icons.security,
//           size: 40.r,
//           color: ColorCodes.whiteColor,
//         ),
//         leadingWidget: Icon(
//           Icons.person_2,
//           size: 40.r,
//           color: ColorCodes.whiteColor,
//         ),
//       ),
//       pageBody: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.work,
//             size: 100.r,
//             color: ColorCodes.primaryColor,
//           ),
//           VerticalGapWidget(AppPaddings.p64.h),
//           TextFormField(
//             controller: usernameController,
//             decoration: InputDecoration(
//               prefixIcon: const Icon(Icons.person),
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: AppPaddings.p12.w,
//                 vertical: 0,
//               ),
//               constraints: BoxConstraints(
//                 minHeight: 50.h,
//               ),
//               labelText: 'Username',
//               filled: true,
//               fillColor: ColorCodes.primaryColor.withOpacity(0.1),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter valid username';
//               }
//               return null;
//             },
//           ),
//           VerticalGapWidget(AppPaddings.p20.h),
//           TextFormField(
//             controller: passwordController,
//             obscureText: true,
//             decoration: InputDecoration(
//               prefixIcon: const Icon(Icons.lock),
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: AppPaddings.p12.w,
//                 vertical: 0,
//               ),
//               constraints: BoxConstraints(
//                 minHeight: 50.h,
//               ),
//               labelText: 'Password',
//               filled: true,
//               fillColor: ColorCodes.primaryColor.withOpacity(0.1),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter valid password';
//               }
//               return null;
//             },
//           ),
//           VerticalGapWidget(AppPaddings.p64.h),
//           ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: ColorCodes.primaryColor,
//                 // shape: RoundedRectangleBorder(
//                 //   borderRadius: BorderRadius.circular(8.0),
//                 // ),
//               ),
//             onPressed: login,
//             child: SizedBox(
//             height: 50.h,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Login',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: ColorCodes.whiteColor,
//                   ),
//                 ),
//                 // const Icon(
//                 //   Icons.label_important,
//                 //   color: ColorCodes.whiteColor,
//                 // ),
//               ],
//             ),
//           )
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/constants/app_paddings.dart';
import 'package:hr_app/core/constants/color_codes.dart';
import 'package:hr_app/core/utils/shared_preferences_service.dart';
import 'package:hr_app/core/widgets/common_page_widgets/common_page_boiler_plate.dart';
import 'package:hr_app/core/widgets/gap_widgets/vertical_gap_consistent.dart';
import 'package:hr_app/features/authentication/bloc/auth_state.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../core/widgets/common_page_widgets/common_app_bar.dart';
import '../../../navigation/bottom_navigator_view.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    // Updated login function
    void login() async {
      context.read<AuthBloc>().add(
            LoginEvent(
              email: usernameController.text,
              password: passwordController.text,
            ),
          );
      // final String username = usernameController.text;
      // final String password = passwordController.text;
      //
      // // Prepare the login request body
      // final Map<String, String> requestBody = {
      //   'email': username,
      //   'password': password,
      // };
      //
      // String? getEmployeeIdFromToken(String token) {
      //   try {
      //     final payloadBase64 = token.split('.')[1];
      //     final normalizedBase64 = base64.normalize(payloadBase64);
      //     final decodedPayload = utf8.decode(base64.decode(normalizedBase64));
      //     final payloadMap = json.decode(decodedPayload);
      //
      //     return payloadMap['userId'] as String?;
      //   } catch (e) {
      //     // Handle decoding error
      //     print('Token decoding error: $e');
      //     return null;
      //   }
      // }
      //
      // // Send the login request
      // try {
      //   final response = await http.post(
      //     Uri.parse('http://192.168.8.105:5000/auth/login'),
      //     headers: {'Content-Type': 'application/json'},
      //     body: jsonEncode(requestBody),
      //   );
      //
      //   if (response.statusCode == 201) {
      //     // Successful login
      //     final Map<String, dynamic> responseBody = json.decode(response.body);
      //     final String accessToken = responseBody['access_token'];
      //
      //     // Store the token securely (e.g., using Flutter Secure Storage)
      //     // Navigate to the next screen
      //     await SharedPreferencesService().setToken(accessToken);
      //     context.read<AuthBloc>().add(SetEmployeeIdEvent(employeeId: getEmployeeIdFromToken(accessToken) ?? ''));
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const BottomNavigationView(),
      //       ),
      //     );
      //   } else {
      //     // Handle login failure
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Login failed. Please try again.')),
      //     );
      //   }
      // } catch (e) {
      //   // Handle network error
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('Network error. Please try again.')),
      //   );
      // }
    }

    String? getEmployeeIdFromToken(String token) {
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

    return CommonPageBoilerPlate(
      isNeedToApplySafeArea: false,
      appBarPreferredSize: 80.h,
      commonAppBar: CommonAppBar(
        titleWidget: const Text('Login', style: TextStyle(fontSize: 24)),
        actionWidget: Icon(
          Icons.security,
          size: 40.r,
          color: ColorCodes.whiteColor,
        ),
        leadingWidget: Icon(
          Icons.person_2,
          size: 40.r,
          color: ColorCodes.whiteColor,
        ),
      ),
      pageBody: BlocConsumer<AuthBloc, AuthState>(
          listenWhen: (current, previous) =>
              current.loginStatus != previous.loginStatus,
          listener: (context, state) async {
            if (state.loginStatus == LoginStatus.success) {
              var token = await SharedPreferencesService().getToken() ?? '';
              context.read<AuthBloc>().add(SetEmployeeIdEvent(
                  employeeId: getEmployeeIdFromToken(token) ?? ''));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavigationView(),
                ),
              );
            } else if (state.loginStatus == LoginStatus.error) {
              Alert(
                context: context,
                type: AlertType.error,
                title: "LOGIN FAILED",
                desc: "Login Failed..! Please try again.",
                buttons: [
                  DialogButton(
                    onPressed: () => Navigator.pop(context),
                    width: 120.w,
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ).show();
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.work,
                  size: 100.r,
                  color: ColorCodes.primaryColor,
                ),
                VerticalGapWidget(AppPaddings.p64.h),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppPaddings.p12.w,
                      vertical: 0,
                    ),
                    constraints: BoxConstraints(
                      minHeight: 50.h,
                    ),
                    labelText: 'Username',
                    filled: true,
                    fillColor: ColorCodes.primaryColor.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                VerticalGapWidget(AppPaddings.p20.h),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppPaddings.p12.w,
                      vertical: 0,
                    ),
                    constraints: BoxConstraints(
                      minHeight: 50.h,
                    ),
                    labelText: 'Password',
                    filled: true,
                    fillColor: ColorCodes.primaryColor.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                VerticalGapWidget(AppPaddings.p64.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorCodes.primaryColor,
                  ),
                  onPressed: login,
                  child: SizedBox(
                    height: 50.h,
                    child: state.loginStatus == LoginStatus.submitting
                        ? Center(
                            child: SizedBox(
                              width: 16.w,
                              height: 16.w,
                              child: const CircularProgressIndicator(
                                color: ColorCodes.whiteColor,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: ColorCodes.whiteColor,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
