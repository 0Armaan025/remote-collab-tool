import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:remote_collab_tool/constants/constants.dart';
import 'package:remote_collab_tool/features/auth/models/file.dart';

class FileUploadRepository {
  // function to store the file

  Future<String> uploadFile(
      BuildContext context, File file, String companyName) async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please select a file"),
      ));
    } else {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref =
          storage.ref().child('files/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();

      FileModel fileModel = FileModel(
          type: fileType!,
          name: fileName!,
          downloadUrl: downloadURL,
          uploadedByUid: FirebaseAuth.instance.currentUser?.uid ?? '',
          companyName: companyName);

      await FirebaseFirestore.instance
          .collection('files')
          .doc(fileName!)
          .set(fileModel.toMap());
    }

    return 'hi';
  }
}
