import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/constants/app_paddings.dart';
import 'package:hr_app/core/constants/color_codes.dart';
import 'package:hr_app/core/widgets/common_page_widgets/common_app_bar.dart';
import 'package:hr_app/core/widgets/common_page_widgets/common_page_boiler_plate.dart';
import 'package:hr_app/core/widgets/gap_widgets/vertical_gap_consistent.dart';
import 'package:hr_app/features/authentication/bloc/auth_bloc.dart';
import 'package:hr_app/features/home/bloc/home_bloc.dart';
import 'package:hr_app/features/home/bloc/home_event.dart';
import 'package:hr_app/features/home/bloc/home_state.dart';
import 'package:hr_app/features/home/presentation/widgets/attendance_indicator.dart';
import 'package:hr_app/features/home/presentation/widgets/project_card.dart';

import '../../../authentication/bloc/auth_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isOnline = false;

  void _toggleOnlineStatus() {
    setState(() {
      isOnline = !isOnline;
    });
    context.read<AuthBloc>().add(
          UpdateStatus(
            status: isOnline,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(
          GetAttendanceDataEvent(
            userId: context.read<AuthBloc>().state.employeeId,
          ),
        );

    return CommonPageBoilerPlate(
      isNeedToApplySafeArea: false,
      appBarPreferredSize: 80.h,
      commonAppBar: CommonAppBar(
        titleWidget: const Text('Home', style: TextStyle(fontSize: 24)),
        leadingWidget: Icon(
          Icons.home_rounded,
          size: 40.r,
          color: ColorCodes.whiteColor,
        ),
      ),
      pageBody: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalGapWidget(AppPaddings.p20.h),
            const Text(
              'Attendance (Last 5 Days)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            VerticalGapWidget(AppPaddings.p12.h),
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < state.attendanceList.length; i++)
                    AttendanceIndicator(
                      status: state.attendanceList[i].status,
                      color: state.attendanceList[i].status == 'Present'
                          ? ColorCodes.greenColor
                          : state.attendanceList[i].status == 'Leave'
                              ? ColorCodes.yellowColor
                              : ColorCodes.redColor,
                    ),
                ],
              );
            }),
            VerticalGapWidget(AppPaddings.p20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Online Status: ${isOnline ? 'Online' : 'Offline'}',
                  style: TextStyle(fontSize: 18.sp),
                ),
                ElevatedButton(
                  onPressed: _toggleOnlineStatus,
                  child: Text(isOnline ? 'Clock Out' : 'Clock In'),
                ),
              ],
            ),
            VerticalGapWidget(AppPaddings.p20.h),
            const Text(
              'Projects',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            VerticalGapWidget(AppPaddings.p12.h),
            const ProjectCard(
              name: 'Project A',
              status: 'In Progress',
              role: 'Project Manager',
              startDate: '2022-12-25',
            ),
            const ProjectCard(
              name: 'Project B',
              status: 'Completed',
              role: 'Developer',
              startDate: '2022-12-25',
            ),
            const ProjectCard(
              name: 'Project C',
              status: 'Delayed',
              role: 'Designer',
              startDate: '2022-12-25',
            ),
          ],
        ),
      ),
    );
  }
}
