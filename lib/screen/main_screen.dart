import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_life/Notifiers/api_service_firebase.dart';
import 'package:my_life/Notifiers/main_state.dart';
import 'package:my_life/screen/habit%20screens/create_habit_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const screenRoute = 'main_screen';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 6.h),
            Row(
              children: [
                SizedBox(width: 8.w),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    Provider.of<ApiServiceFirebase>(
                      context,
                    ).profileModel!.imageUrl,
                  ),
                ),
                SizedBox(width: 60.w),
                Icon(FontAwesomeIcons.bell, size: 24.sp, color: Colors.black),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (Provider.of<ApiServiceFirebase>(
                            context,
                          ).profileModel!.fullname ==
                          "")
                      ? ""
                      : Provider.of<ApiServiceFirebase>(
                        context,
                      ).profileModel!.fullname,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'keep Striving',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              "Today's Task",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w900),
            ),
            Text(
              "${Provider.of<MainState>(context).getMonthName(DateTime.now().month)} ${DateTime.now().day}, ${DateTime.now().year}",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 90.w,
                      height: 20.h,
                      margin: EdgeInsets.only(top: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 90.w,
                      height: 20.h,
                      margin: EdgeInsets.only(top: 14, right: 14),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      width: 90.w,
                      height: 20.h,
                      margin: EdgeInsets.only(top: 15, right: 15),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      width: 90.w,
                      height: 20.h,
                      margin: EdgeInsets.only(top: 20, right: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 154, 228, 156),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "5:20 AM",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              "Workout",
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "!Grate job",
                              style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          'lib/assets/images/6.svg',
                          width: 200,
                          height: 200,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                "View All",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Text("Your Progress for Today", style: TextStyle(fontSize: 15.sp)),
            SizedBox(height: 2.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  LinearProgressIndicator(
                    value: 0.5, // 0.0 -> 1.0
                    minHeight: 30,
                    backgroundColor: Colors.grey[300],
                    color: const Color.fromARGB(255, 154, 228, 156),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  Text("50% completed"),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                SvgPicture.asset(
                  'lib/assets/images/7.svg',
                  width: 200,
                  height: 200,
                ),
                Column(
                  children: [
                    Text(
                      "Make",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "New Habit",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushNamed(CreateHabitScreen.screenRoute);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 30.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          "Start",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
