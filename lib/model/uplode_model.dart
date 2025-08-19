import 'dart:io';

class FileUploadModel {
  late File file;
  late String name;

  FileUploadModel({
    required this.file,
    required this.name,
  });

  FileUploadModel.empty();

  FileUploadModel.fromJson(Map<String, dynamic> json) {
    try {
      file = json['file'];
    } catch (e) {}
    try {
      name = json['name'];
    } catch (e) {}
  }
}
  