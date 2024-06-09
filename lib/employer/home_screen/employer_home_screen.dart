import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remote_collab_tool/global.dart';

class EmployerHomeScreen extends StatefulWidget {
  const EmployerHomeScreen({super.key});

  @override
  State<EmployerHomeScreen> createState() => _EmployerHomeScreenState();
}

class _EmployerHomeScreenState extends State<EmployerHomeScreen> {
  String? uid;
  String? orgId;

  Map<String, dynamic>? data;
  @override
  void initState() {
    uid = sharedPreferences!.getString("uid");
    orgId = sharedPreferences!.getString("orgID");
    FirebaseFirestore.instance
        .collection("organization")
        .doc(orgId)
        .get()
        .then((value) {
      data = value.data();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          orgId!,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                "Your Employees - ",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              data!["employees"] == null || data!["Employees"] == []
                  ? Container()
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
