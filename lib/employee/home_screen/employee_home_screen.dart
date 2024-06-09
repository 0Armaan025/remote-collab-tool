import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remote_collab_tool/common/appbar/appbar.dart';
import 'package:remote_collab_tool/common/navbar/navbar.dart';
import 'package:remote_collab_tool/global.dart';
import 'package:remote_collab_tool/theme/pallete.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  List<bool> _taskCompletion = [false, false, false];
  List<DateTime?> deadlines = [
    DateTime.now().add(Duration(hours: 3)), // 3 hours
    DateTime.now().add(Duration(minutes: 45)), // 45 minutes

    null,
  ];
  String? uid;
  String? orgID;
  @override
  void initState() {
    super.initState();
    uid = sharedPreferences?.getString("uid");
    orgID = sharedPreferences?.getString("orgID");
  }

  TextEditingController orgIDController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      appBar: createAppBar(),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Good evening, Armaan 👋",
                style: GoogleFonts.poppins(
                  color: Pallete.headlineTextColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "10th June, 2024",
                style: GoogleFonts.sansita(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://images.unsplash.com/photo-1717684566059-4d16b456c72a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw4fHx8ZW58MHx8fHx8",
                      ),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.1),
                      child: Center(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red.withOpacity(0.4),
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "",
                  style: GoogleFonts.pacifico(
                    color: Pallete.headlineTextColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 1,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(4.0),
                alignment: Alignment.topLeft,
                child: Text(
                  "Your Assigned Tasks:",
                  style: GoogleFonts.nobile(
                    color: Pallete.headlineTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              StreamBuilder(
                stream: orgID != null
                    ? FirebaseFirestore.instance
                        .collection("organization")
                        .doc(orgID)
                        .collection(
                            FirebaseAuth.instance.currentUser?.uid ?? '')
                        .snapshots()
                    : null, // Return null if orgID is null or empty
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Map<String, dynamic> task =
                            snapshot.data!.docs[index].data();
                        return ListTile(
                          title: Text(
                            task["task"],
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  } else {
                    return Container(); // Return an empty container if snapshot has no data
                  }
                },
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 1,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: deadlines.map((deadline) {
                  if (deadline == null) {
                    return Expanded(
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              "No Deadlines",
                              style: GoogleFonts.poppins(
                                color: Pallete.headlineTextColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    int endTime = deadline.millisecondsSinceEpoch;
                    return Expanded(
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "Deadline",
                                style: GoogleFonts.poppins(
                                  color: Pallete.headlineTextColor,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              CountdownTimer(
                                endTime: endTime,
                                widgetBuilder: (_, time) {
                                  if (time == null) {
                                    return Text(
                                      "Time's up!",
                                      style: GoogleFonts.poppins(
                                        color: Pallete.headlineTextColor,
                                        fontSize: 16,
                                      ),
                                    );
                                  }
                                  int totalTime = (time.hours ?? 0) * 3600 +
                                      (time.min ?? 0) * 1 +
                                      (time.sec ?? 0);
                                  double percentage = totalTime /
                                      (5 *
                                          3600); // Assume 5 hours total for demo
                                  return Column(
                                    children: [
                                      CustomPaint(
                                        size: Size(60, 60),
                                        painter: TimerPainter(percentage),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${time.hours ?? 0}h ${time.min ?? 0}m ${time.sec ?? 0}s',
                                        style: GoogleFonts.poppins(
                                          color: Pallete.headlineTextColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }).toList(),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Made with 💜 by the FireSquad 🔥",
                  style: GoogleFonts.poppins(color: Pallete.headlineTextColor),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class TimerPainter extends CustomPainter {
  final double percentage;

  TimerPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.pink.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    Paint complete = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
    double progressAngle = 2 * 3.14 * percentage;
    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2),
      -3.14 / 2,
      progressAngle,
      false,
      complete,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
