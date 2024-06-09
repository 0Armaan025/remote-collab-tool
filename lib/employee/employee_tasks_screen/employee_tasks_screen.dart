import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      children: [
        // Section: My Tasks
        _buildSectionHeader('My Tasks'),
        _buildTaskItem('Task 1'),
        _buildTaskItem('Task 2'),
        _buildTaskItem('Task 3'),
        // Section: Groupmates' Tasks
        _buildSectionHeader('Groupmates\' Tasks'),
        _buildTaskItem('Task A'),
        _buildTaskItem('Task B'),
        _buildTaskItem('Task C'),
      ],
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
          _buildTimer(),
        ],
      ),
    );
  }

  Widget _buildTimer() {
    // Example Timer Widget (Replace this with your implementation)
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
            '24h', // Example time, replace with actual timer value
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
