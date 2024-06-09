import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remote_collab_tool/common/navbar/navbar.dart';
import 'package:remote_collab_tool/theme/pallete.dart';

class EmployeeOrganizationViewScreen extends StatefulWidget {
  const EmployeeOrganizationViewScreen({super.key});

  @override
  State<EmployeeOrganizationViewScreen> createState() =>
      _EmployeeOrganizationViewScreenState();
}

class _EmployeeOrganizationViewScreenState
    extends State<EmployeeOrganizationViewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "RCT",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 223, 223, 223).withOpacity(0.7),
                Color.fromARGB(255, 0, 0, 0).withOpacity(0.2)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[300],
          tabs: [
            Tab(text: "Tasks"),
            Tab(text: "Members"),
            Tab(text: "Chat"),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
      backgroundColor: Pallete.bgColor,
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                TasksScreen(),
                MembersScreen(),
                ChatScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: size.height * 0.17),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        children: [
          // Section: My Tasks
          _buildSectionHeader('My Tasks'),
          _buildTaskItem('Task 1'),
          _buildTaskItem('Task 2'),
          _buildTaskItem('Task 3'),
          // Section: Groupmates' Tasks
          _buildSectionHeader('Groupmates\' Tasks'),
          _buildGroupmateTaskItem('Task A', Icons.close, 'John', '24h'),
          _buildGroupmateTaskItem('Task B', Icons.check, 'Emma', '12h'),
          _buildGroupmateTaskItem('Task C', Icons.close, 'Mike', '48h'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTaskItem(String taskName) {
    return ListTile(
      title: Text(
        taskName,
        style: GoogleFonts.poppins(),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: false, // Change this to manage task completion
            onChanged: (value) {
              // Handle task completion
            },
          ),
          SizedBox(width: 10),
          // Timer Widget (You can replace this with your timer implementation)
          _buildTimer('12h'),
        ],
      ),
    );
  }

  Widget _buildGroupmateTaskItem(
      String taskName, IconData icon, String userName, String timeLeft) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(userName[0]),
        backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      ),
      title: Text(
        taskName,
        style: GoogleFonts.poppins(),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(width: 10),
          // Timer Widget (You can replace this with your timer implementation)
          _buildTimer(timeLeft),
        ],
      ),
    );
  }

  Widget _buildTimer(String timeLeft) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer, color: Colors.white),
          SizedBox(width: 5),
          Text(
            timeLeft, // Example time, replace with actual timer value
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class MembersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Members Screen'));
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Chat Screen'));
  }
}
