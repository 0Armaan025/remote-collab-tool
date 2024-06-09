import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:remote_collab_tool/models/user.dart';

class EmployeeProfile extends StatefulWidget {
  UserModal user;
  String orgID;
  EmployeeProfile({super.key, required this.user, required this.orgID});

  @override
  State<EmployeeProfile> createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user.username,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.user.profilePictureUrl),
                radius: 60,
              ),
            ),
            Center(
              child: SizedBox(
                height: 25,
              ),
            ),
            Center(
              child: Text(
                widget.user.username,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "Tasks List -",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("organization")
                  .doc(widget.orgID)
                  .collection(widget.user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
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
                      )
                    : Container();
              },
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(
                            "Enter the task  -",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          content: Column(
                            children: [
                              TextFormField(
                                controller: taskController,
                                decoration:
                                    InputDecoration(hintText: "Enter task"),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  String taskID = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                  FirebaseFirestore.instance
                                      .collection("organization")
                                      .doc(widget.orgID)
                                      .collection(widget.user.uid)
                                      .doc(taskID)
                                      .set({
                                    "id": taskID,
                                    "task": taskController.text,
                                    "done": false,
                                  });
                                },
                                child: Text("Done")),
                          ],
                        ));
              },
              child: Text(
                "Add tasks",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  backgroundColor: Colors.pink[50]),
            )
          ],
        ),
      ),
    );
  }
}
