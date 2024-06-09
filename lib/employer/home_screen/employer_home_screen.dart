import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remote_collab_tool/employer/home_screen/Employee_profile.dart';
import 'package:remote_collab_tool/global.dart';
import 'package:remote_collab_tool/models/user.dart';
import 'dart:developer' as developer;

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
    developer.log(orgId!);
    FirebaseFirestore.instance
        .collection("organization")
        .doc(orgId)
        .get()
        .then((value) {
      setState(
        () {
          data = value.data();
        },
      );
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
              data!["Employees"] == null || data!["Employees"] == []
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: data!["Employees"].length,
                      itemBuilder: (context, index) {
                        String employeeId = data!["Employees"][index];

                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection("user")
                              .doc(employeeId)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Text("Error loading data");
                            }
                            if (!snapshot.hasData) {
                              return Text("No data available");
                            }

                            UserModal user = UserModal.fromMap(
                                snapshot.data!.data() as Map<String, dynamic>);
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => EmployeeProfile(
                                            user: user, orgID: orgId!)));
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(user.profilePictureUrl),
                                    radius: 30,
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    user.username,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
