import 'package:flutter/material.dart';
import 'package:my_life/Notifiers/api_service_firebase.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String screenRoute = 'profile_screen';
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

  static Widget progressBar(String day, double value, Color color) {
    return Column(
      children: [
        Container(
          height: 100 * value,
          width: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          day,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  static Widget favoriteCard(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: 120,
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.green.shade700),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  static Widget usageStat(IconData icon, String title, String percent) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.black),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          percent,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Row(
              children: [
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 12.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 250, 247),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'lib/assets/images/5.png',
                      fit: BoxFit.cover,
                      width: 8.w,
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(width: 8.w),
            // ----- Header with background and profile -----
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        Provider.of<ApiServiceFirebase>(
                              context,
                              listen: false,
                            ).profileModel?.imageUrl ??
                            '',
                      ), // خلفية مؤقتة
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.18,
                  left: (screenWidth / 2) - 50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      Provider.of<ApiServiceFirebase>(
                            context,
                            listen: false,
                          ).profileModel?.imageUrl ??
                          '',
                    ), // صورة البروفايل
                  ),
                ),
              ],
            ),

            const SizedBox(height: 70),

            // ----- Name and description -----
            Text(
              Provider.of<ApiServiceFirebase>(
                    context,
                    listen: false,
                  ).profileModel?.fullname ??
                  '',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "I'm gonna be the Hokage Someday! Believe it!",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 10),

            // ----- Edit Profile Button -----
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

            // ----- Progress Section -----
            const Text(
              'Your Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileScreen.progressBar('Feb 28', 0.6, Colors.amber),
                  ProfileScreen.progressBar('Feb 29', 1.0, Colors.green),
                  ProfileScreen.progressBar('Feb 30', 0.7, Colors.yellow),
                  ProfileScreen.progressBar(
                    'Feb 31\nToday',
                    0.4,
                    Colors.orange,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'View History',
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 30),

            // ----- Favorites Section -----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Favorites',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 15),

            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ProfileScreen.favoriteCard('Work Out', Icons.fitness_center),
                  ProfileScreen.favoriteCard(
                    'Meditate',
                    Icons.self_improvement,
                  ),
                  ProfileScreen.favoriteCard('Filming', Icons.videocam),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ----- Usage Statistics -----
            const Text(
              'Usage',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileScreen.usageStat(
                  Icons.camera_alt,
                  'Camera Detection',
                  '14%',
                ),
                ProfileScreen.usageStat(
                  Icons.access_time,
                  'Pomodoro Technique',
                  '32%',
                ),
                ProfileScreen.usageStat(
                  Icons.calendar_month,
                  'Follow Schedule',
                  '54%',
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ----- Logout Button -----
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
