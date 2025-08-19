import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_life/Notifiers/api_service_firebase.dart';
import 'package:my_life/model/uplode_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});
  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  List<FileUploadModel?> listImages = [];
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
      body: Stack(
        children: [
          Image.asset(
            'lib/assets/images/1.jpg',
            width: double.infinity,
            fit: BoxFit.cover,
            height: 33.h,
          ),
          Column(
            children: [
              SizedBox(height: 30.h),
              Container(
                height: 70.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      child: Image.asset(
                        "lib/assets/images/2.png",
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 70.h,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 2.h),
                        listImages.isNotEmpty
                            ? CircleAvatar(
                              maxRadius: 15.h,
                              child: Image.file(
                                listImages[0]!.file,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                            : GestureDetector(
                              onTap: () async {
                                // Handle photo upload
                                final result = await pickImage(
                                  ImageSource.gallery,
                                );
                                if (result == null) {
                                  return;
                                }
                                setState(() {
                                  listImages.add(result);
                                });
                                //Provider.of<ApiServiceFirebase>(context, listen: false).uploadPhoto();
                              },
                              child: CircleAvatar(
                                backgroundColor: Color.fromARGB(
                                  255,
                                  218,
                                  218,
                                  219,
                                ),
                                maxRadius: 15.h,
                                child: Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Text('Add Photo'),
                                ),
                              ),
                            ),
                        SizedBox(height: 2.h),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              focusColor: Colors.black,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            // Handle account creation
                          },
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
