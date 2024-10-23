import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/utils/assets.dart';
import 'package:hr_app/features/chat_bot/presentation/screens/chat_bot_view.dart';
import 'package:hr_app/features/chat_bot/presentation/widgets/selection_card.dart';

import '../../../../core/constants/app_paddings.dart';
import '../../../../core/constants/color_codes.dart';
import '../../../../core/widgets/common_page_widgets/common_app_bar.dart';
import '../../../../core/widgets/common_page_widgets/common_page_boiler_plate.dart';
import '../../../../core/widgets/gap_widgets/vertical_gap_consistent.dart';
import 'game_view.dart';

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
            SelectionCard(
              asset: Assets.games,
              title: 'Games',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameView(
                      title: 'Summer Maze',
                      url: 'https://www.jopi.com/gam/summer-maze/',
                    ),
                  ),
                );
              },
            ),
            VerticalGapWidget(AppPaddings.p16.h),
            SelectionCard(
              asset: Assets.bot,
              title: 'Chat Bot',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
