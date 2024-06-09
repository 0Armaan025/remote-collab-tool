import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:remote_collab_tool/common/navbar/employer-navbar.dart';
import 'package:remote_collab_tool/common/navbar/navbar.dart';
import 'package:remote_collab_tool/employer/home_screen/Employee_profile.dart';
import 'package:remote_collab_tool/global.dart';
import 'package:remote_collab_tool/models/user.dart';
import 'dart:developer' as developer;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:confetti/confetti.dart';
import 'package:lottie/lottie.dart';
import 'package:remote_collab_tool/theme/pallete.dart';

class EmployerHomeScreen extends StatefulWidget {
  const EmployerHomeScreen({super.key});

  @override
  State<EmployerHomeScreen> createState() => _EmployerHomeScreenState();
}

class _EmployerHomeScreenState extends State<EmployerHomeScreen> {
  String? uid;
  String? orgId;
  Map<String, dynamic>? data;
  List<UserModal> employees = [];
  late ConfettiController _confettiController;

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
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    uid = sharedPreferences?.getString("uid");
    orgId = sharedPreferences?.getString("orgID");
    if (orgId != null) {
      fetchOrganizationData();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> fetchOrganizationData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> orgDoc = await FirebaseFirestore
          .instance
          .collection("organization")
          .doc(orgId)
          .get();
      if (orgDoc.exists && orgDoc.data() != null) {
        setState(() {
          data = orgDoc.data();
        });
        if (data != null && data!["Employees"] != null) {
          fetchEmployeesData(List<String>.from(data!["Employees"]));
        }
      } else {
        print("No organization data found");
      }
    } catch (e) {
      print("Error fetching organization data: $e");
    }
  }

  Future<void> fetchEmployeesData(List<String> employeeIds) async {
    List<UserModal> fetchedEmployees = [];
    for (String id in employeeIds) {
      try {
        DocumentSnapshot<Map<String, dynamic>> userDoc =
            await FirebaseFirestore.instance.collection("user").doc(id).get();
        if (userDoc.exists && userDoc.data() != null) {
          fetchedEmployees.add(UserModal.fromMap(userDoc.data()!));
        }
      } catch (e) {
        print("Error fetching user data for $id: $e");
      }
    }
    setState(() {
      employees = fetchedEmployees;
    });
  }

  AppBar createAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'RCT',
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
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

      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('EEEE, MMMM d, y').format(DateTime.now());
    return Scaffold(
      bottomNavigationBar: MyEmployerBottomNavigationBar(),
      backgroundColor: Pallete.bgColor,
      appBar: createAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Company Name',
                      style: GoogleFonts.pacifico(
                        color: Colors.black,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Evening, Armaan',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        today,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.pink[50],
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://www.example.com/your_image.jpg'), // Replace with your image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Text(
                        'Welcome to Company Name',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Text(
                    "Your Employees",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (employees.isEmpty)
                    Text("No employees found")
                  else
                    SizedBox(
                      height: 200,
                      child: AnimationLimiter(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: employees.length,
                          itemBuilder: (context, index) {
                            UserModal user = employees[index];
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (c) => EmployeeProfile(
                                            user: user,
                                            orgID: orgId ?? '',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.all(10),
                                      child: Container(
                                        width: 150,
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                user.profilePictureUrl ??
                                                    'https://via.placeholder.com/150', // Placeholder image URL
                                              ),
                                              radius: 30,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              user.username,
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    ),
                ],
              ),
            ),
          ),
          // Adding confetti animation
        ],
      ),
    );
  }
}
