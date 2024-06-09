import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remote_collab_tool/common/navbar/navbar.dart';
import 'package:remote_collab_tool/common/appbar/appbar.dart';
import 'package:remote_collab_tool/theme/pallete.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ShareFilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to history page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FileHistoryScreen()),
              );
            },
          ),
        ],
        title: Text('RTC', style: GoogleFonts.pacifico()),
        centerTitle: true,
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Handle file upload area tap
                  uploadFile();
                },
                child: Container(
                  color: Pallete.bgColor, // Semi-transparent color
                  child: Center(
                    child: Icon(
                      Icons.file_upload,
                      size: 100,
                      color:
                          Pallete.headlineTextColor, // File upload icon color
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter file name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle send button press
                    },
                    child: Text("Send", style: GoogleFonts.pacifico()),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadFile() async {
    // Upload file to Firebase Storage
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final File file = File(result.files.single.path!);
      final String fileName = file.path;
      final Reference storageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      final UploadTask uploadTask = storageRef.putFile(file);
      final TaskSnapshot downloadUrl = (await uploadTask);
      final String url = await downloadUrl.ref.getDownloadURL();
      print('File uploaded to Firebase Storage: $url');
    } else {
      // User canceled the picker
    }
  }
}

class FileHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      appBar: AppBar(
        title: Text("File History", style: GoogleFonts.montserrat()),
      ),
      body: ListTile(
        leading: CircleAvatar(),
        title: Text("new.png"),
        subtitle: Text("File Type: PNG"),
        trailing: IconButton(
          icon: Icon(Icons.open_in_new),
          onPressed: () {
            // Handle open button press
          },
        ),
      ),
    );
  }
}
