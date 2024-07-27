import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/constants/color_codes.dart';
import 'package:hr_app/core/widgets/common_page_widgets/common_app_bar.dart';
import 'package:hr_app/core/widgets/common_page_widgets/common_page_boiler_plate.dart';
import 'package:hr_app/features/home/presentation/widgets/attendance_indicator.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return CommonPageBoilerPlate(
      commonAppBar: const CommonAppBar(
        toolbarHeight: 100,
        titleWidget: Text('Home', style: TextStyle(fontSize: 20)),
        leadingWidget: Icon(Icons.menu),
      ),
      pageBody: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attendance (Last 5 Days)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AttendanceIndicator(status: 'Present', color: Colors.green),
                AttendanceIndicator(status: 'Leave', color: Colors.yellow),
                AttendanceIndicator(status: 'Present', color: Colors.green),
                AttendanceIndicator(status: 'Present', color: Colors.red),
                AttendanceIndicator(status: 'Present', color: Colors.green),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Online Status: ${isOnline ? 'Online' : 'Offline'}',
                  style: const TextStyle(fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: _toggleOnlineStatus,
                  child: Text(isOnline ? 'Clock Out' : 'Clock In'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Projects',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildProjectCard(
                'Project A', 'In Progress', 'Developer', '2024-01-01'),
            _buildProjectCard(
                'Project B', 'Completed', 'Lead Developer', '2023-06-15'),
            _buildProjectCard('Project C', 'Pending', 'Tester', '2024-05-10'),
            const SizedBox(height: 20),
            const Text(
              'Salary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'LKR 120,000.00',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(
      String name, String status, String role, String startDate) {
    return Container(
      color: ColorCodes.primaryColor.withOpacity(0.1),
      child: ListTile(
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: status == 'In Progress'
                    ? Colors.green
                    : status == 'Completed'
                        ? Colors.blue
                        : Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Status: $status',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text('Role: $role'),
            Text('Start Date: $startDate'),
          ],
        ),
      ),
    );
  }
}
