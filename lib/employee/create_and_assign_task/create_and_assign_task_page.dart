import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:remote_collab_tool/theme/pallete.dart';

class CreateAndAssignTaskPage extends StatefulWidget {
  @override
  _CreateAndAssignTaskPageState createState() =>
      _CreateAndAssignTaskPageState();
}

class _CreateAndAssignTaskPageState extends State<CreateAndAssignTaskPage> {
  final _taskNameController = TextEditingController();
  String? _selectedAssignee;
  DateTime? _selectedDeadline;
  TimeOfDay? _selectedTime;
  List<String> _assignees = [];
  List<String> _assigneeUIDs = [];

  @override
  void initState() {
    super.initState();
    _fetchAssignees();
  }

  Future<void> _fetchAssignees() async {
    try {
      // Fetch the organization document
      DocumentSnapshot orgDoc = await FirebaseFirestore.instance
          .collection('organization')
          .limit(1)
          .get()
          .then((snapshot) => snapshot.docs.first);

      List<dynamic> employeeUIDs = orgDoc.get('Employees');

      List<String> assignees = [];
      for (var uid in employeeUIDs) {
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('user').doc(uid).get();
        assignees.add(userDoc.get('userName'));
      }

      setState(() {
        _assignees = assignees;
        _assigneeUIDs = List<String>.from(employeeUIDs);
      });
    } catch (e) {
      print('Error fetching assignees: $e');
    }
  }

  void _pickDeadline() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDeadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDeadline) {
      setState(() {
        _selectedDeadline = pickedDate;
      });
    }
  }

  void _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _saveTask() {
    final taskName = _taskNameController.text;
    final assignee = _selectedAssignee;
    final deadline = _selectedDeadline;
    final time = _selectedTime;

    if (taskName.isEmpty ||
        assignee == null ||
        deadline == null ||
        time == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final DateTime deadlineWithTime = DateTime(
      deadline.year,
      deadline.month,
      deadline.day,
      time.hour,
      time.minute,
    );

    print('Task: $taskName');
    print('Assignee: $assignee');
    print(
        'Deadline: ${DateFormat('yyyy-MM-dd – kk:mm').format(deadlineWithTime)}');

    _taskNameController.clear();
    setState(() {
      _selectedAssignee = null;
      _selectedDeadline = null;
      _selectedTime = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task assigned successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
        title: Text('RCT', style: GoogleFonts.poppins()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task Name',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _taskNameController,
              decoration: InputDecoration(
                hintText: 'Enter task name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.pink[50],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Assign To',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: _selectedAssignee,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.pink[50],
              ),
              hint: Text('Select assignee'),
              items: _assignees.map((assignee) {
                return DropdownMenuItem<String>(
                  value: assignee,
                  child: Text(assignee),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAssignee = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Deadline',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              onTap: _pickDeadline,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.pinkAccent),
              ),
              tileColor: Colors.pink[50],
              title: Text(
                _selectedDeadline == null
                    ? 'Select deadline'
                    : DateFormat('yyyy-MM-dd').format(_selectedDeadline!),
                style: GoogleFonts.poppins(),
              ),
              trailing: Icon(Icons.calendar_today, color: Colors.pinkAccent),
            ),
            SizedBox(height: 10),
            ListTile(
              onTap: _pickTime,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.pinkAccent),
              ),
              tileColor: Colors.pink[50],
              title: Text(
                _selectedTime == null
                    ? 'Select time'
                    : _selectedTime!.format(context),
                style: GoogleFonts.poppins(),
              ),
              trailing: Icon(Icons.access_time, color: Colors.pinkAccent),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _saveTask,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Pallete.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 10,
                  shadowColor: Colors.pinkAccent.withOpacity(0.5),
                ),
                child: Text(
                  'Assign Task',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    super.dispose();
  }
}
