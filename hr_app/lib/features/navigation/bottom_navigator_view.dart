import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/chat_bot/chat_bot_view.dart';
import 'package:hr_app/features/contact/reach_hr_view.dart';
import 'package:hr_app/features/home/home_view.dart';
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
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
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
                Icons.dashboard_customize_outlined,
                size: 32.w,
                color: ColorCodes.lightGreyColor,
              ),
              activeIcon: Icon(
                Icons.dashboard_customize,
                size: 32.w,
                color: Colors.teal,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.mail_outline,
                size: 32.w,
                color: ColorCodes.lightGreyColor,
              ),
              activeIcon: Icon(
                Icons.mail,
                size: 32.w,
                color: Colors.teal,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.movie_outlined,
                size: 32.w,
                color: ColorCodes.lightGreyColor,
              ),
              activeIcon: Icon(
                Icons.movie,
                size: 32.w,
                color: Colors.teal,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_outlined,
                size: 32.w,
                color: ColorCodes.lightGreyColor,
              ),
              activeIcon: Icon(
                Icons.person_2_rounded,
                size: 32.w,
                color: Colors.teal,
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
