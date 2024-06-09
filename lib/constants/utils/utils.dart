import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:remote_collab_tool/constants/constants.dart';

void moveScreen(
    {required BuildContext context,
    required Widget widget,
    bool isPushReplacement = false}) {
  if (isPushReplacement) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => widget));
  } else {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }
}

File? userFile;

Future<void> _pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    PlatformFile file = result.files.first;
    File normalFile = File(file.path!);
    userFile = normalFile;
    fileType = file.extension;
    fileName = file.name;
  }
}
