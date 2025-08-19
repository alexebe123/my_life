import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ApiServiceFirebase extends ChangeNotifier {
  static ApiServiceFirebase? _instance;
  late FirebaseFirestore firebaseFirestore;
  FirebaseAuth auth = FirebaseAuth.instance;
  late bool isLoggedIn;
  User? user;
  GoogleSignIn googleSignIn = GoogleSignIn.instance;
  
    FirebaseStorage storage = FirebaseStorage.instance;

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
      account = await _googleSignIn.authenticate(
        scopeHint: scopes,
      );
      return account;
    } on GoogleSignInException catch (e) {
      print('Google Sign In error:\n$e');
          return null;
      } catch (error) {
        print('Unexpected Google Sign-In error: $error');
        return null;
      }
  }

  User? getAccount() {
    user = auth.currentUser;
    if (user == null) {
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
    }
    return user;
  }

  Future uploadPhoto( File file) async {
    // Implement photo upload logic here
    Reference storageReference =
        storage.ref().child('images/' + file.path.split('/').last);
    try {
      final uploadTask = storageReference.putFile(file);
      await uploadTask.whenComplete(() => print('File Uploaded')).catchError((e) {
        print("error upload : " + e);
      });
      late String urldowload;
      await storageReference.getDownloadURL().then((fileURL) {
        urldowload = fileURL;
      });
      return urldowload;
    } catch (e) {
      print(e.toString());
    }
  }
}
