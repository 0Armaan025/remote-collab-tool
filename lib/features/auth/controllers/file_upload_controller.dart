import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remote_collab_tool/features/auth/repositories/file_upload_repository.dart';

class FileUploadController {
  final FileUploadRepository _fileUploadRepository = FileUploadRepository();

  Future<String> uploadFile(
      BuildContext context, File file, String companyName) async {
    return _fileUploadRepository.uploadFile(context, file, companyName);
  }
}
