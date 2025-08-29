import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  static const screenRoute = 'setting_screen';
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 5.h),
          InkWell(
            onTap: () => Navigator.pushNamed(context, 'profile_screen'),
            child: SettingContainer(icon: Icons.person, title: 'Profile'),
          ),
          SizedBox(height: 2.h),
          InkWell(
            onTap: () => Navigator.pushNamed(context, 'habit_screen'),
            child: SettingContainer(
              icon: FontAwesomeIcons.hexagonNodesBolt,
              title: 'Habits',
            ),
          ),
        ],
      ),
    );
  }
}

class SettingContainer extends StatelessWidget {
  const SettingContainer({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      width: double.infinity,
      height: 10.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30.sp),
          SizedBox(width: 10.w),
          Text(title, style: TextStyle(fontSize: 12.sp)),
        ],
      ),
    );
  }
}
