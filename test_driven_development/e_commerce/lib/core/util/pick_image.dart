import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<String?> _pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    return pickedFile.path;
  }
}
