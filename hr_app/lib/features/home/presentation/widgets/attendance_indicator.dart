import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        ClipRect(
          child: Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: const Center(
              child: Icon(
                Icons.manage_accounts_rounded,
                color: Colors.white,
              ),
            )
          ),
          // radius: 20,
          // backgroundColor: color,
        ),
        const SizedBox(height: 5),
        Text(status),
      ],
    );
  }
}
