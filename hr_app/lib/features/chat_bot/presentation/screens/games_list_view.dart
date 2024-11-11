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

class GamesListView extends StatelessWidget {
  const GamesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageBoilerPlate(
      isNeedToApplySafeArea: false,
      appBarPreferredSize: 80.h,
      commonAppBar: CommonAppBar(
        titleWidget: const Text('Games', style: TextStyle(fontSize: 24)),
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
              asset: Assets.summerMaze,
              title: 'Summer Maze',
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
              asset: Assets.keyQuest,
              title: 'Key Quest',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameView(
                      title: 'Key Quest',
                      url: 'https://www.jopi.com/gam/key-quest/',
                    ),
                  ),
                );
              },
            ),
            VerticalGapWidget(AppPaddings.p16.h),
            SelectionCard(
              asset: Assets.paintingTiles,
              title: 'Painting Tiles',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameView(
                      title: 'Painting Tiles',
                      url: 'https://www.jopi.com/gam/painting-tiles/',
                    ),
                  ),
                );
              },
            ),
            VerticalGapWidget(AppPaddings.p16.h),
            SelectionCard(
              asset: Assets.wayToHome,
              title: 'Way To Home',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameView(
                      title: 'Way To Home',
                      url: 'https://www.jopi.com/gam/way-to-home/',
                    ),
                  ),
                );
              },
            ),
            VerticalGapWidget(AppPaddings.p16.h),
            SelectionCard(
              asset: Assets.miniGolf,
              title: 'Pixel Mini Golf',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameView(
                      title: 'Pixel Mini Golf',
                      url: 'https://www.jopi.com/gam/pixel-mini-golf/',
                    ),
                  ),
                );
              },
            ),
            VerticalGapWidget(AppPaddings.p16.h),
            SelectionCard(
              asset: Assets.neonBricks,
              title: 'Neon Bricks',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameView(
                      title: 'Neon Bricks',
                      url: 'https://www.jopi.com/gam/neon-bricks/',
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

