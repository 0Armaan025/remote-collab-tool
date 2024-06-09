import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:remote_collab_tool/constants/constants.dart';
import 'package:remote_collab_tool/constants/utils/utils.dart';
import 'package:remote_collab_tool/employee/employee_org_view_screen/employee_organization_view_screen.dart';
import 'package:remote_collab_tool/employee/home_screen/employee_home_screen.dart';
import 'package:remote_collab_tool/employee/profile_page/profile_page.dart';
import 'package:remote_collab_tool/features/document_editing/document_editing_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => MyBottomNavigationBarState();
}

class MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.group,
                text: 'Group',
              ),
              GButton(
                icon: Icons.home,
                text: 'Search',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
                selectedIndex = _selectedIndex;

                if (index == 0) {
                  moveScreen(context: context, widget: EmployeeHomeScreen());
                } else if (index == 1) {
                  moveScreen(
                      context: context,
                      widget: EmployeeOrganizationViewScreen());
                } else if (index == 2) {
                  moveScreen(context: context, widget: DocumentEditingScreen());
                } else if (index == 3) {
                  moveScreen(context: context, widget: ProfilePage());
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
