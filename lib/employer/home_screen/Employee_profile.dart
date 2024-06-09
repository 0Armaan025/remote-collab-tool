import 'dart:html';

import 'package:flutter/material.dart';
import 'package:remote_collab_tool/models/user.dart';

class EmployeeProfile extends StatefulWidget {
  UserModal user;
  EmployeeProfile({super.key, required this.user});

  @override
  State<EmployeeProfile> createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.user.profilePictureUrl),
              radius: 30,
            ),
            SizedBox(height: 20,),
            Text(widget.user.username,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){}, child: Text("Chat with the user"))
          ],
        ),
      ),
    );
  }
}
