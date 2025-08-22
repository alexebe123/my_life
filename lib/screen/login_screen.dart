import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_life/Notifiers/api_service_firebase.dart';
import 'package:my_life/screen/create_account.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const screenRoute = 'login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'int',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w900,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green, // لون الحواف
                        width: 2, // سمك الحواف
                      ),
                      shape: BoxShape.circle,
                      color: Colors.transparent, // لون الدائرة
                    ),
                  ),
                  Container(
                    width: 19,
                    height: 19,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green, // لون الحواف
                        width: 2, // سمك الحواف
                      ),
                      shape: BoxShape.circle,
                      color: Colors.transparent, // لون الدائرة
                    ),
                  ),
                ],
              ),
              Text(
                'FocalP',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Image.asset('lib/assets/images/4.png', height: 25.h),
          SizedBox(height: 2.h),
          Text(
            'Stay',
            style: TextStyle(fontSize: 20.sp, fontFamily: 'Poppins'),
          ),
          // SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Cus',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontFamily: 'Poppins',
                  color: Colors.green,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green, // لون الحواف
                        width: 2, // سمك الحواف
                      ),
                      shape: BoxShape.circle,
                      color: Colors.transparent, // لون الدائرة
                    ),
                  ),
                  Container(
                    width: 19,
                    height: 19,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green, // لون الحواف
                        width: 2, // سمك الحواف
                      ),
                      shape: BoxShape.circle,
                      color: Colors.transparent, // لون الدائرة
                    ),
                  ),
                ],
              ),
              Text(
                'F',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontFamily: 'Poppins',
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Text(
            'Please log into your existing accont',
            style: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins'),
          ),
          SizedBox(height: 2.h),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), // لون الظل
                  spreadRadius: 2, // مدى انتشار الظل
                  blurRadius: 8, // درجة التمويه
                  offset: Offset(4, 4), // اتجاه الظل (يمين، أسفل)
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () async {
                // Handle Google sign-in
                final account =
                    await Provider.of<ApiServiceFirebase>(
                      context,
                      listen: false,
                    ).getGoogleAccount();
                if (account != null) {
                  // Successfully signed in with Google
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CreateAccount()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to sign in with Google')),
                  );
                }
              },
              child: Container(
                height: 10.h,
                width: 90.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign up with Google",
                      style: TextStyle(color: Colors.black, fontSize: 18.sp),
                    ),
                    SizedBox(width: 5.w),
                    Icon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                      size: 30.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), // لون الظل
                  spreadRadius: 2, // مدى انتشار الظل
                  blurRadius: 8, // درجة التمويه
                  offset: Offset(4, 4), // اتجاه الظل (يمين، أسفل)
                ),
              ],
            ),
            child: Container(
              height: 10.h,
              width: 90.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign up with Facebook",
                    style: TextStyle(color: Colors.black, fontSize: 18.sp),
                  ),
                  SizedBox(width: 5.w),
                  Icon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blue,
                    size: 30.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
