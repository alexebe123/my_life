import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_life/Notifiers/api_service_firebase.dart';
import 'package:my_life/model/profile_model.dart';
import 'package:my_life/screen/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/services.dart';
import 'package:my_life/model/uplode_model.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String fullNameError = "";
  String imageUrlError = "";
  List<FileUploadModel?> listImages = [];
  String buttonload = "";

  ProfileModel profileModel = ProfileModel.empty();
  _defaultValues() {
    fullNameError = "";
  }

  bool _validateInfo(void Function(void Function()) setState) {
    bool result = true;
    _defaultValues();
    if (profileModel.fullname == "") {
      result = false;
      setState(() {
        fullNameError = "أدخل الإسم";
      });
    }
    if (listImages.isEmpty) {
      result = false;
      setState(() {
        imageUrlError = "يجب ادخال صورة شخصية";
      });
    }
    return result;
  }

  Future<FileUploadModel?> pickImage(ImageSource source) async {
    FileUploadModel? finalResult;
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return null;
      }

      finalResult = FileUploadModel(file: File(image.path), name: image.name);

      try {
        final compresedResult = await FlutterImageCompress.compressWithFile(
          image.path,
          minWidth: 720,
          minHeight: 540,
          quality: 80,
        );
        if (compresedResult != null) {
          finalResult.file.writeAsBytesSync(compresedResult);
        }
      } catch (e) {
        print("amidi error $e");
      }
      return finalResult;
    } on PlatformException catch (e) {
      print("failed to pick image: $e");
    }
    return finalResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 5.w),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 12.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 247, 233),
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
                SizedBox(width: 8.w),
              ],
            ),
            SizedBox(height: 6.h),
            SizedBox(
              width: 80.w,
              child: Text(
                'Create account using Google',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color.fromARGB(255, 207, 202, 200),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            listImages.isNotEmpty
                ? ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: Container(
                    width: 50.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: CircleAvatar(
                      maxRadius: 15.h,
                      child: Image.file(
                        listImages[0]!.file,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                : Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // Handle photo upload
                        // Handle photo upload
                        final result = await pickImage(ImageSource.gallery);
                        if (result == null) {
                          return;
                        }
                        setState(() {
                          listImages.add(result);
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Container(
                          width: 50.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Container(
                            color: const Color.fromARGB(255, 233, 247, 233),
                          ),
                        ),
                      ),
                    ),
                    Text('Add Photo'),
                  ],
                ),
            SizedBox(height: 2.h),
            Container(
              alignment: Alignment.topLeft,
              width: 80.w,
              child: Text('Your Name', style: TextStyle(fontSize: 16.sp)),
            ),
            SizedBox(
              width: 80.w,
              child: TextField(
                textDirection: TextDirection.ltr,
                onChanged: (value) {
                  if (fullNameError != "") {
                    setState(() {
                      fullNameError = "";
                    });
                  } else {
                    profileModel.fullname = value;
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ), // عندما يكون غير مفعّل
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ), // عند الضغط عليه
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 1.h),
                        Text('and'),
                        SizedBox(width: 1.h),
                        Text(
                          'Terms and Condition',
                          style: TextStyle(
                            color: Colors.green,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.green, // لون الخط
                            decorationThickness: 2,
                          ),
                        ),
                        SizedBox(width: 1.h),
                        Text('I agree to'),
                        SizedBox(width: 1.h),
                      ],
                    ),
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: Colors.green,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.green, // لون الخط
                        decorationThickness: 2,
                      ),
                    ),
                  ],
                ),
                Checkbox(value: false, onChanged: (value) {}),
                SizedBox(width: 6.w),
              ],
            ),
            SizedBox(height: 2.h),
            GestureDetector(
              onTap: () async {
                if (!_validateInfo(setState)) {
                  return;
                }
                if (buttonload != "") {
                  return;
                }
                setState(() {
                  buttonload = "registration";
                });
                profileModel.imageUrl = await Provider.of<ApiServiceFirebase>(
                  context,
                  listen: false,
                ).uploadPhoto(listImages[0]!.file);
                profileModel.id =
                    Provider.of<ApiServiceFirebase>(
                      context,
                      listen: false,
                    ).getAccount()!.uid;
                profileModel.createdTime = DateTime.now();
                await Provider.of<ApiServiceFirebase>(
                  context,
                  listen: false,
                ).addProfile(profileModel);
                await Provider.of<ApiServiceFirebase>(
                  context,
                  listen: false,
                ).getProfile();
                setState(() {
                  buttonload = "";
                });
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: 80.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
