import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_life/model/habit_model.dart';
import 'package:my_life/model/profile_model.dart';
import 'package:my_life/res/app_constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServiceFirebase extends ChangeNotifier {
  static ApiServiceFirebase? _instance;
  late FirebaseFirestore firebaseFirestore;
  fb.FirebaseAuth auth = fb.FirebaseAuth.instance;
  late bool isLoggedIn;
  fb.User? user;

  ProfileModel? profileModel = ProfileModel.empty();
  GoogleSignIn googleSignIn = GoogleSignIn.instance;

  ApiServiceFirebase._internal() {
    firebaseFirestore = FirebaseFirestore.instance;
  }

  static ApiServiceFirebase get instance {
    _instance ??= ApiServiceFirebase._internal();
    return _instance!;
  }

  List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;

  Future<void> _initializeGoogleSignIn() async {
    try {
      await _googleSignIn.initialize();
      _isGoogleSignInInitialized = true;
    } catch (e) {
      print('Failed to initialize Google Sign-In: $e');
    }
  }

  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      await _initializeGoogleSignIn();
    }
  }

  Future<GoogleSignInAccount?> getGoogleAccount() async {
    await _ensureGoogleSignInInitialized();
    GoogleSignInAccount? account;
    try {
      account = await _googleSignIn.authenticate(scopeHint: scopes);
      profileModel?.id = account.id;
      profileModel?.email = account.email;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', account.email);
      return account;
    } on GoogleSignInException catch (e) {
      print('Google Sign In error:\n$e');
      return null;
    } catch (error) {
      print('Unexpected Google Sign-In error: $error');
      return null;
    }
  }

  Future<ProfileModel?> getAccountInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email') ?? '';
      if (email.isNotEmpty) {
        profileModel?.email = email;
        isLoggedIn = true;
        return profileModel;
      }
      isLoggedIn = false;
      return null;
    } catch (e) {
      print('Error retrieving account info: $e');
      return null;
    }
  }

  Future<fb.User?> getAccount() async {
    user = auth.currentUser;
    if (user == null) {
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
    }
    return user;
  }

  Future<String> uploadPhoto(File file) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';

    try {
      final response = await Supabase.instance.client.storage
          .from('images')
          .upload(fileName, file);

      if (response.isEmpty) {
        throw 'Upload failed!';
      }

      // جلب الرابط المباشر
      final publicUrl = Supabase.instance.client.storage
          .from('images')
          .getPublicUrl(fileName);

      return publicUrl;
    } catch (e) {
      print('Upload error: $e');
      return "";
    }
  }

  Future addProfile(ProfileModel profile) async {
    try {
      await firebaseFirestore
          .collection(AppConstants.collectionIdUsers)
          .add(profile.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ProfileModel?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? '';
    try {
      final data =
          await firebaseFirestore
              .collection(AppConstants.collectionIdUsers)
              .where("email", isEqualTo: email)
              .limit(1)
              .get();
      if (data.docs.isNotEmpty) {
        final list =
            data.docs.map<ProfileModel>((doc) {
              var map = doc.data();
              map["\$id"] = doc.id;
              return ProfileModel.fromJson(map);
            }).toList();
        profileModel = list[0];
      }
      return profileModel;
    } catch (e) {
      //  print(e.toString());
      return profileModel;
    }
  }

  Future addHabit(Habit habit) async {
    try {
      await firebaseFirestore
          .collection(AppConstants.collectionIdHabits)
          .add(habit.toJson());
    } catch (e) {
      print(e.toString());
    }
  }
}
