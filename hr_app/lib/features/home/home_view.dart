import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attendance (Last 5 Days)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAttendanceIndicator('Present', Colors.green),
                _buildAttendanceIndicator('Leave', Colors.yellow),
                _buildAttendanceIndicator('Absent', Colors.red),
                _buildAttendanceIndicator('Present', Colors.green),
                _buildAttendanceIndicator('Absent', Colors.red),
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

  Widget _buildAttendanceIndicator(String status, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: color,
        ),
        const SizedBox(height: 5),
        Text(status),
      ],
    );
  }

  Widget _buildProjectCard(
      String name, String status, String role, String startDate) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: const Color(0xFFEEF2FF),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/project_background.png'),
            fit: BoxFit.cover,
          ),
        ),
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
      ),
    );
  }
}
