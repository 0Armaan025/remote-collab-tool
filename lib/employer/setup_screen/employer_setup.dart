import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remote_collab_tool/common/appbar/appbar.dart';
import 'package:remote_collab_tool/employer/home_screen/employer_home_screen.dart';
import 'package:remote_collab_tool/global.dart';
import 'dart:io';

import 'package:remote_collab_tool/theme/pallete.dart';

class EmployerSetupPage extends StatefulWidget {
  String uid;
  EmployerSetupPage({
    required this.uid,
  });

  @override
  State<EmployerSetupPage> createState() => _EmployerSetupPageState();
}

class _EmployerSetupPageState extends State<EmployerSetupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _placeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: createAppBar(),
      backgroundColor: Pallete.bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "Let's setup\nYour organization",
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Organization Name',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Organization Email',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _placeController,
                  decoration: InputDecoration(
                    labelText: 'Place',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    if (_nameController.text != "" &&
                        _emailController.text != "" &&
                        _placeController.text != "") {
                      String orgainizationID =
                          DateTime.now().millisecondsSinceEpoch.toString();

                      FirebaseFirestore.instance
                          .collection("organization")
                          .doc(orgainizationID)
                          .set({
                        "organizationID": orgainizationID,
                        "name": _nameController.text,
                        "email": _nameController.text,
                        "place": _placeController.text,
                        "Employees": [],
                      });
                      FirebaseFirestore.instance
                          .collection("user")
                          .doc(FirebaseAuth.instance.currentUser?.uid ?? '')
                          .update({
                        "orgainizationID": orgainizationID,
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => EmployerHomeScreen()));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                      color: Pallete.buttonColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        'Go Ahead',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Pallete.buttonTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
