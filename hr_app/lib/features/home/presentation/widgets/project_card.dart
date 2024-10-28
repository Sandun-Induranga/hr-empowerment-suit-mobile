import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/constants/app_paddings.dart';
import 'package:hr_app/core/widgets/gap_widgets/vertical_gap_consistent.dart';

import '../../../../core/constants/color_codes.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.name,
    required this.status,
    required this.description,
    required this.startDate,
  });

  final String name;
  final String status;
  final String description;
  final String startDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorCodes.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      margin: EdgeInsets.only(bottom: 10.h),
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPaddings.p12,
                    vertical: AppPaddings.p4,
                  ),
                  decoration: BoxDecoration(
                    color: status == 'In Progress'
                        ? ColorCodes.greenColor
                        : status == 'Completed'
                            ? ColorCodes.redColor
                            : ColorCodes.yellowColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Status: $status',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorCodes.whiteColor,
                    ),
                  ),
                ),
                VerticalGapWidget(AppPaddings.p8.h),
                SizedBox(
                  width: 1.sw - 180.w,
                  child: Text(
                    'Description: $description',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                ),
                VerticalGapWidget(AppPaddings.p4.h),
                Text('Start Date: $startDate'),
              ],
            ),
            Icon(
              Icons.pivot_table_chart_rounded,
              size: 50.r,
              color: status == 'In Progress'
                  ? ColorCodes.greenColor
                  : status == 'Completed'
                      ? ColorCodes.redColor
                      : ColorCodes.yellowColor,
            ),
          ],
        ),
      ),
    );
  }
}
