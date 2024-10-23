import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/widgets/gap_widgets/vertical_gap_consistent.dart';

class SelectionCard extends StatelessWidget {
  const SelectionCard({
    super.key,
    required this.asset,
    required this.title,
    required this.onTap,
  });

  final String asset;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(asset, width: 1.sw, height: 150.h),
            VerticalGapWidget(20.h),
             Text(title, style: const TextStyle(fontSize: 20)),
            VerticalGapWidget(20.h),
          ],
        ),
      ),
    );
  }
}
