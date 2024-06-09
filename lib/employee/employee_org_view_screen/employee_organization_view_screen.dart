import 'package:flutter/material.dart';
import 'package:remote_collab_tool/common/appbar/appbar.dart';
import 'package:remote_collab_tool/common/navbar/navbar.dart';
import 'package:remote_collab_tool/theme/pallete.dart';

class EmployeeOrganizationViewScreen extends StatefulWidget {
  const EmployeeOrganizationViewScreen({super.key});

  @override
  State<EmployeeOrganizationViewScreen> createState() =>
      _EmployeeOrganizationViewScreenState();
}

class _EmployeeOrganizationViewScreenState
    extends State<EmployeeOrganizationViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: createAppBar(),
        bottomNavigationBar: MyBottomNavigationBar(),
        backgroundColor: Pallete.bgColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [],
            ),
          ),
        ));
  }
}
