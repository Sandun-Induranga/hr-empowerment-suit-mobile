import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/widgets/gap_widgets/vertical_gap_consistent.dart';

class SelectionCard extends StatelessWidget {
  const SelectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/games.jpg'),
        VerticalGapWidget(20.h),
        const Text('Play Games')
      ],
    );
  }
}

