import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_paddings.dart';
import '../../../../core/constants/color_codes.dart';
import '../../../../core/widgets/common_page_widgets/common_app_bar.dart';
import '../../../../core/widgets/common_page_widgets/common_page_boiler_plate.dart';
import '../../../../core/widgets/gap_widgets/vertical_gap_consistent.dart';

class FunZoneView extends StatelessWidget {
  const FunZoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageBoilerPlate(
      isNeedToApplySafeArea: false,
      appBarPreferredSize: 80.h,
      commonAppBar: CommonAppBar(
        titleWidget: const Text('Fun Zone', style: TextStyle(fontSize: 24)),
        leadingWidget: Icon(
          Icons.person_2_rounded,
          size: 40.r,
          color: ColorCodes.whiteColor,
        ),
      ),
      pageBody: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VerticalGapWidget(AppPaddings.p16.h),
            VerticalGapWidget(AppPaddings.p16.h),
          ],
        ),
      ),
    );
  }
}

