import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/color_codes.dart';
import '../../../../core/widgets/common_page_widgets/common_page_boiler_plate.dart';
import '../../../../core/widgets/gap_widgets/vertical_gap_consistent.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    return CommonPageBoilerPlate(

      horizontalPadding: 0,
      pageBody: Container(
        color: ColorCodes.whiteColor,
        child: Column(
          children: [
            VerticalGapWidget(8.h),
            Expanded(
              child: InAppWebView(
                // https://www.jopi.com/gam/key-quest/
                // https://www.jopi.com/gam/painting-tiles/
                // https://www.jopi.com/gam/space-slide/
                // https://www.jopi.com/gam/master-sudoku/
                initialUrlRequest: URLRequest(url: WebUri('https://www.jopi.com/gam/summer-maze/')),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useShouldOverrideUrlLoading: false,
                    useOnLoadResource: false,
                  ),
                ),
                onLoadStop:
                    (InAppWebViewController controller, Uri? url) async {},
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  return NavigationActionPolicy.ALLOW;
                },
                onUpdateVisitedHistory: (controller, url, isReload) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

