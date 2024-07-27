import 'package:flutter/material.dart';

class AttendanceIndicator extends StatelessWidget {
  const AttendanceIndicator({
    super.key,
    required this.color,
    required this.status,
  });

  final Color color;
  final String status;

  @override
  Widget build(BuildContext context) {
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
}
