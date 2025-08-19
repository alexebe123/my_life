import 'package:flutter/material.dart';
import 'package:my_life/Notifiers/api_service_firebase.dart';
import 'package:my_life/screen/create_account_screen.dart';
import 'package:my_life/screen/home.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Text(
              "Create an account",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            SizedBox(height: 5.h),
            Text(
              "To create an account enter your email and password",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white38, fontSize: 15),
            ),
            SizedBox(height: 5.h),
            GestureDetector(
              onTap: () async {
                // Handle Google Sign-In
                final account = await Provider.of<ApiServiceFirebase>(
                  context,
                  listen: false,
                ).getGoogleAccount();
                if (account != null) {
                  // Successfully signed in with Google
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CreateAccountScreen()),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to sign in with Google'),
                    ),
                  );
                }
                  },
              child: Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.google, color: Colors.red),
                    SizedBox(width: 10),
                    Text(
                      "Sign in with Google",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.facebook, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    "Sign in with Facebook",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
