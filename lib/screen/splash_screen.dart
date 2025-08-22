import 'package:flutter/material.dart';
import 'package:my_life/Notifiers/api_service_firebase.dart';
import 'package:my_life/Notifiers/main_state.dart';
import 'package:my_life/screen/create_account.dart';
import 'package:my_life/screen/login_screen.dart';
import 'package:my_life/screen/main_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const screenRoute = 'splash_screen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    load();
  }

  Future load() async {
    try {
      await Provider.of<MainState>(
        context,
        listen: false,
      ).checkInternetConnection();
    } catch (e) {}
    if (Provider.of<MainState>(context, listen: false).isInternetFuond) {
      try {
        try {
          Provider.of<ApiServiceFirebase>(context, listen: false).getAccount();
        } catch (e) {}
        final result =
            await Provider.of<ApiServiceFirebase>(
              context,
              listen: false,
            ).getProfile();

        bool isLoggedIn =
            Provider.of<ApiServiceFirebase>(context, listen: false).isLoggedIn;
        if (!isLoggedIn) {
          Navigator.of(context).pushReplacementNamed(LoginScreen.screenRoute);
        } else {
          if (result != null) {
            Navigator.of(context).pushReplacementNamed(MainScreen.screenRoute);
          } else {
            Navigator.of(
              context,
            ).pushReplacementNamed(CreateAccount.screenRoute);
          }
        }
      } catch (e) {}
    }
  }

  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
