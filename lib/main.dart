import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_life/Notifiers/providers.dart';
import 'package:my_life/screen/login%20system/create_account.dart';
import 'package:my_life/screen/habit%20screens/habit_screen.dart';
import 'package:my_life/screen/login%20system/login_screen.dart';
import 'package:my_life/screen/main_screen.dart';
import 'package:my_life/screen/login%20system/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_life/screen/base_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  await Supabase.initialize(
    url: 'https://bpcfdupkxxalmryqdkym.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJwY2ZkdXBreHhhbG1yeXFka3ltIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU4MTc4MjYsImV4cCI6MjA3MTM5MzgyNn0.vH_iCWdNQ_KC-nHPhhYbX15PgFek8D_JghWojvTidL4',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'My Life',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('ar', '')],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            initialRoute: SplashScreen.screenRoute,
            routes: {
              SplashScreen.screenRoute: (context) => const SplashScreen(),
              LoginScreen.screenRoute: (context) => const LoginScreen(),
              MainScreen.screenRoute: (context) => const MainScreen(),
              CreateAccount.screenRoute: (context) => const CreateAccount(),
              BaseScreen.screenRoute: (context) => const BaseScreen(),
              HabitScreen.screenRoute: (context) => const HabitScreen(),
            },
          );
        },
      ),
    );
  }
}
