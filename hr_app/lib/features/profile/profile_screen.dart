import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/constants/app_paddings.dart';
import 'package:hr_app/core/utils/shared_preferences_service.dart';
import 'package:hr_app/core/widgets/common_page_widgets/common_page_boiler_plate.dart';
import 'package:hr_app/core/widgets/gap_widgets/horizontal_gap_consistent.dart';
import 'package:hr_app/core/widgets/gap_widgets/vertical_gap_consistent.dart';
import 'package:hr_app/features/authentication/bloc/auth_state.dart';
import 'package:hr_app/features/authentication/presentation/screens/login_view.dart';
import 'package:intl/intl.dart';

import '../../core/constants/color_codes.dart';
import '../../core/widgets/common_page_widgets/common_app_bar.dart';
import '../authentication/bloc/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _joinDateController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = context.read<AuthBloc>().state.employee?.name ?? '';
    _emailController.text =
        context.read<AuthBloc>().state.employee?.email ?? '';
    _phoneController.text =
        context.read<AuthBloc>().state.employee?.mobile ?? '';
    _addressController.text =
        context.read<AuthBloc>().state.employee?.address ?? '';
    _birthdayController.text = DateFormat('yyyy-MM-dd').format(
        context.read<AuthBloc>().state.employee?.birthday ?? DateTime.now());
    _joinDateController.text = DateFormat('yyyy-MM-dd').format(
        context.read<AuthBloc>().state.employee?.birthday ?? DateTime.now());
    _positionController.text =
        context.read<AuthBloc>().state.employee?.position ?? '';
    _salaryController.text =
        context.read<AuthBloc>().state.employee?.salary.toString() ?? '';
    _statusController.text =
        (context.read<AuthBloc>().state.employee?.status ?? '') == 'true'
            ? 'Online'
            : 'Offline';
  }

  void _updateProfile() {
    Navigator.of(context).pop();
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('Name', _nameController),
                _buildTextField('Email', _emailController),
                _buildTextField('Phone', _phoneController),
                _buildTextField('Address', _addressController),
                _buildTextField('Birthday (yyyy-MM-dd)', _birthdayController),
                _buildTextField('Position', _positionController),
                _buildTextField('Salary', _salaryController),
                _buildTextField('Status', _statusController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonPageBoilerPlate(
      isNeedToApplySafeArea: false,
      appBarPreferredSize: 80.h,
      commonAppBar: CommonAppBar(
        titleWidget: const Text('Profile', style: TextStyle(fontSize: 24)),
        leadingWidget: Icon(
          Icons.person_2_rounded,
          size: 40.r,
          color: ColorCodes.whiteColor,
        ),
        actionWidget: IconButton(
          icon: const Icon(Icons.settings_rounded),
          onPressed: _editProfile,
          color: ColorCodes.whiteColor,
        ),
      ),
      pageBody: SingleChildScrollView(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                VerticalGapWidget(AppPaddings.p16.h),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: MemoryImage(const Base64Decoder().convert(
                      (state.employee?.picture ?? '').split(',').length != 2
                          ? state.employee?.picture ?? ''
                          : (state.employee?.picture ?? '').split(',')[1])),
                ),
                VerticalGapWidget(AppPaddings.p16.h),
                Text(
                  state.employee?.name ?? '',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                VerticalGapWidget(AppPaddings.p8.h),
                Text(
                  state.employee?.email ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                VerticalGapWidget(AppPaddings.p16.h),
                const Divider(),
                _buildProfileItem('Phone', state.employee?.mobile ?? ''),
                _buildProfileItem('Address', state.employee?.address ?? ''),
                _buildProfileItem(
                    'Birthday',
                    DateFormat('yyyy-MM-dd')
                        .format(state.employee?.birthday ?? DateTime.now())),
                _buildProfileItem('Position', state.employee?.position ?? ''),
                _buildProfileItem('Salary',
                    '\$${state.employee?.salary.toStringAsFixed(2) ?? ''}'),
                _buildProfileItem(
                  'Status',
                  (state.status ? 'Online' : 'Offline'),
                ),
                const Divider(),
                VerticalGapWidget(AppPaddings.p16.h),
                const Text(
                  'This is your details that you have provided to us.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                VerticalGapWidget(AppPaddings.p16.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorCodes.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    side: const BorderSide(color: ColorCodes.primaryColor),
                  ),
                  onPressed: () async {
                    var sharedPreferencesService = SharedPreferencesService();
                    await sharedPreferencesService.setToken('');
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ),
                      (route) => route.isFirst,
                    );
                  },
                  child: SizedBox(
                    height: 40.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: ColorCodes.primaryColor,
                          ),
                        ),
                        HorizontalGapWidget(10.w),
                        const Icon(
                          Icons.logout,
                          color: ColorCodes.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              '$title: ',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          HorizontalGapWidget(AppPaddings.p16.w),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
