import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/chat_bot/presentation/screens/chat_bot_view.dart';
import 'package:hr_app/features/contact/presentation/reach_hr_view.dart';
import 'package:hr_app/features/home/presentation/screens/home_view.dart';
import 'package:hr_app/features/profile/profile_screen.dart';

import '../../core/constants/color_codes.dart';
import '../../core/widgets/common_page_widgets/common_page_boiler_plate.dart';

class BottomNavigationView extends StatefulWidget {
  static int _selectedIndex = 0;

  const BottomNavigationView({super.key});

  @override
  BottomNavigationViewState createState() => BottomNavigationViewState();
}

class BottomNavigationViewState extends State<BottomNavigationView> {
  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      BottomNavigationView._selectedIndex = index;
      // context.read<AuthBloc>().add(
      //   ChangeCurrentIndexEvent(currentIndex: index),
      // );
    });
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const ReachHRScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CommonPageBoilerPlate(
      horizontalPadding: 0,
      isNeedToApplySafeArea: false,
      pageBody: _screens[BottomNavigationView._selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: ColorCodes.primaryColor,
          border: Border(
            top: BorderSide(
              color: ColorCodes.whiteColor,
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: ColorCodes.primaryColor,
          elevation: 0,
          currentIndex: BottomNavigationView._selectedIndex,
          selectedItemColor: ColorCodes.blackColor,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: ColorCodes.lightGreyColor,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 32.w,
                color: ColorCodes.whiteColor.withOpacity(0.5),
              ),
              activeIcon: Icon(
                Icons.home,
                size: 32.w,
                color: ColorCodes.whiteColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.call_missed_outgoing,
                size: 32.w,
                color: ColorCodes.whiteColor.withOpacity(0.5),
              ),
              activeIcon: Icon(
                Icons.call_missed_outgoing,
                size: 32.w,
                color: ColorCodes.whiteColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.rocket_launch,
                size: 32.w,
                color: ColorCodes.whiteColor.withOpacity(0.5),
              ),
              activeIcon: Icon(
                Icons.rocket_launch,
                size: 32.w,
                color: ColorCodes.whiteColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_rounded,
                size: 32.w,
                color: ColorCodes.whiteColor.withOpacity(0.5),
              ),
              activeIcon: Icon(
                Icons.person_2_rounded,
                size: 32.w,
                color: ColorCodes.whiteColor,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kBottomNavigationBarHeight);
}
