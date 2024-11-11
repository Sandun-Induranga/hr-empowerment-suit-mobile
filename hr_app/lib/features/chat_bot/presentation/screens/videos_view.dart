import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/widgets/common_page_widgets/common_page_boiler_plate.dart';

import '../../../../core/constants/app_paddings.dart';
import '../../../../core/constants/color_codes.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/widgets/common_page_widgets/common_app_bar.dart';
import '../../../../core/widgets/gap_widgets/vertical_gap_consistent.dart';
import '../widgets/selection_card.dart';
import 'game_view.dart';

class VideosView extends StatelessWidget {
  const VideosView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageBoilerPlate(
      isNeedToApplySafeArea: false,
      appBarPreferredSize: 80.h,
      commonAppBar: CommonAppBar(
        titleWidget: const Text('Mind Relax Videos', style: TextStyle(fontSize: 24)),
        leadingWidget: IconButton(
          icon: Padding(
            padding: EdgeInsets.all(16.r),
            child: Icon(
              Icons.arrow_back_ios,
              size: 30.r,
              color: ColorCodes.whiteColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      pageBody: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VerticalGapWidget(AppPaddings.p16.h),
            SelectionCard(
              asset: Assets.videos,
              title: 'Videos 1',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameView(
                      title: 'Videos',
                      url: 'https://www.youtube-nocookie.com/embed/bP9gMpl1gyQ?playlist=bP9gMpl1gyQ&autoplay=1&iv_load_policy=3&loop=1&start=',
                    ),
                  ),
                );
              },
            ),
            VerticalGapWidget(AppPaddings.p16.h),
            SelectionCard(
              asset: Assets.videos,
              title: 'Video 2',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameView(
                      title: 'Videos',
                      url: 'https://www.youtube-nocookie.com/embed/hlWiI4xVXKY?playlist=hlWiI4xVXKY&autoplay=1&iv_load_policy=3&loop=1&start=',
                    ),
                  ),
                );
              },
            ),
            VerticalGapWidget(AppPaddings.p16.h),
            SelectionCard(
              asset: Assets.videos,
              title: 'Video 3',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameView(
                      title: 'Videos',
                      url: 'https://www.youtube-nocookie.com/embed/es4x5R-rV9s?playlist=es4x5R-rV9s&autoplay=1&iv_load_policy=3&loop=1&start=',
                    ),
                  ),
                );
              },
            ),
            VerticalGapWidget(AppPaddings.p16.h),
            SelectionCard(
              asset: Assets.videos,
              title: 'Video 4',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameView(
                      title: 'Videos',
                      url: 'https://www.youtube-nocookie.com/embed/4HVqC4zEPDc?playlist=4HVqC4zEPDc&autoplay=1&iv_load_policy=3&loop=1&start=',
                    ),
                  ),
                );
              },
            ),
            VerticalGapWidget(AppPaddings.p16.h),
          ],
        ),
      ),
    );
  }
}
