import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/widgets/gap_widgets/horizontal_gap_consistent.dart';
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
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        padding: EdgeInsets.all(16.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                asset.startsWith('http')
                    ? Image.network(
                        asset,
                        height: 50.h,
                      )
                    :
                Image.asset(
                  asset,
                  height: 50.h,
                ),
                HorizontalGapWidget(12.w),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 20.r,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
