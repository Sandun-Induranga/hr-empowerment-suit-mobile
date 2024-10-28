import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/constants/app_paddings.dart';
import 'package:hr_app/core/widgets/common_page_widgets/common_app_bar.dart';
import 'package:hr_app/core/widgets/common_page_widgets/common_page_boiler_plate.dart';
import 'package:hr_app/core/widgets/gap_widgets/vertical_gap_consistent.dart';
import 'package:hr_app/features/authentication/bloc/auth_bloc.dart';
import 'package:hr_app/features/home/bloc/home_bloc.dart';
import 'package:hr_app/features/home/bloc/home_event.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/color_codes.dart';
import '../../chat_bot/presentation/screens/game_view.dart';
import '../../home/data/model/leave_request.dart';

class ReachHRScreen extends StatefulWidget {
  const ReachHRScreen({super.key});

  @override
  ReachHRScreenState createState() => ReachHRScreenState();
}

class ReachHRScreenState extends State<ReachHRScreen> {
  final _formKey = GlobalKey<FormState>();
  final _leaveFormKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final _reasonController = TextEditingController();
  String? _selectedProject;
  DateTime? _startDate;
  int? _numOfDays;
  final String _status = 'Pending';

  final List<String> projects = ['Project A', 'Project B', 'Project C'];

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _sendEmail() async {
    final String subject = Uri.encodeComponent(_subjectController.text);
    final String body = Uri.encodeComponent(_messageController.text);
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'hr@feathercodes.com',
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );
    try {
      if (await canLaunch(emailLaunchUri.toString())) {
        await launch(emailLaunchUri.toString());
      } else {
        throw 'Could not launch email';
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  void _submitLeaveRequest() {
    if (_leaveFormKey.currentState!.validate()) {
      context.read<HomeBloc>().add(
            RequestLeaveEvent(
              leaveRequest: LeaveRequest(
                date: _startDate!,
                dayCount: _numOfDays!,
                reason: _reasonController.text,
                status: _status,
                userId: context.read<AuthBloc>().state.employeeId,
              ),
            ),
          );
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _startDate) {
      setState(() {
        _startDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonPageBoilerPlate(
      isNeedToApplySafeArea: false,
      appBarPreferredSize: 80.h,
      commonAppBar: CommonAppBar(
        titleWidget: const Text('Contact HR', style: TextStyle(fontSize: 24)),
        leadingWidget: Icon(
          Icons.call_missed_outgoing,
          size: 40.r,
          color: ColorCodes.whiteColor,
        ),
      ),
      pageBody: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalGapWidget(AppPaddings.p8.h),
            Text(
              'Send Quick Emails to HR',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            VerticalGapWidget(AppPaddings.p20.h),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _subjectController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppPaddings.p12.w,
                        vertical: 0,
                      ),
                      labelText: 'Subject',
                      filled: true,
                      fillColor: ColorCodes.primaryColor.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a subject' : null,
                  ),
                  VerticalGapWidget(AppPaddings.p20.h),
                  TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppPaddings.p12.w,
                        vertical: 0,
                      ),
                      labelText: 'Message',
                      filled: true,
                      fillColor: ColorCodes.primaryColor.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 4,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a message' : null,
                  ),
                  VerticalGapWidget(AppPaddings.p20.h),
                  ElevatedButton(
                    onPressed: _sendEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorCodes.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: _sendEmail,
                      child: SizedBox(
                        height: 50.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Send Message',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: ColorCodes.whiteColor,
                              ),
                            ),
                            const Icon(
                              Icons.send,
                              color: ColorCodes.whiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            VerticalGapWidget(AppPaddings.p32.h),
            Text(
              'Easy Leave Request',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            VerticalGapWidget(AppPaddings.p20.h),
            Form(
              key: _leaveFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppPaddings.p12.w,
                        vertical: 0,
                      ),
                      constraints: BoxConstraints(
                        minHeight: 50.h,
                      ),
                      labelText: 'Start Date',
                      filled: true,
                      fillColor: ColorCodes.primaryColor.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectStartDate(context),
                      ),
                    ),
                    controller: TextEditingController(
                      text: _startDate == null
                          ? ''
                          : DateFormat('yyyy-MM-dd').format(_startDate!),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please select a start date' : null,
                  ),
                  VerticalGapWidget(AppPaddings.p20.h),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppPaddings.p12.w,
                        vertical: 0,
                      ),
                      constraints: BoxConstraints(
                        minHeight: 50.h,
                      ),
                      labelText: 'Number of Days',
                      filled: true,
                      fillColor: ColorCodes.primaryColor.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      _numOfDays = int.tryParse(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter number of days';
                      } else if (int.tryParse(value) == null ||
                          int.tryParse(value)! <= 0) {
                        return 'Please enter a valid number of days';
                      }
                      return null;
                    },
                  ),
                  VerticalGapWidget(AppPaddings.p20.h),
                  TextFormField(
                    controller: _reasonController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppPaddings.p12.w,
                        vertical: 0,
                      ),
                      labelText: 'Reason',
                      filled: true,
                      fillColor: ColorCodes.primaryColor.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 4,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a reason' : null,
                  ),
                  VerticalGapWidget(AppPaddings.p20.h),
                  ElevatedButton(
                    onPressed: _submitLeaveRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorCodes.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: SizedBox(
                      height: 50.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Submit Request',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: ColorCodes.whiteColor,
                            ),
                          ),
                          const Icon(
                            Icons.label_important,
                            color: ColorCodes.whiteColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  VerticalGapWidget(AppPaddings.p20.h),
                  ElevatedButton(
                    onPressed: () {
                      Uri uri =
                          Uri.https('form.jotform.com', '/242603610622445');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const GameView(
                              title: 'Feedback Form',
                              url: 'https://form.jotform.com/242603610622445'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorCodes.primaryColor.withOpacity(0.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: SizedBox(
                      height: 50.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Submit Feedback',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: ColorCodes.whiteColor,
                            ),
                          ),
                          const Icon(
                            Icons.feedback,
                            color: ColorCodes.whiteColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
