import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remote_collab_tool/common/navbar/navbar.dart';
import 'package:remote_collab_tool/theme/pallete.dart';

class EmployerMembersScreen extends StatefulWidget {
  @override
  _EmployerMembersScreenState createState() => _EmployerMembersScreenState();
}

class _EmployerMembersScreenState extends State<EmployerMembersScreen> {
  final Map<String, String> _memberRoles = {
    'Member 1': 'Member',
    'Member 2': 'Member',
    'Member 3': 'Member',
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(),
      backgroundColor: Pallete.bgColor,
      appBar: AppBar(
        title: Text('RCT', style: GoogleFonts.poppins(fontSize: 20)),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.black),
            onPressed: _saveRoles,
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            _buildSectionHeader('Leader'),
            _buildLeaderTile('John Doe', 'assets/profile_pic.jpg'),
            _buildSectionHeader('Members'),
            ..._buildMemberTiles(),
            // Add more member tiles as needed
          ],
        ),
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
          color: Pallete.headlineTextColor,
        ),
      ),
    );
  }

  Widget _buildLeaderTile(String leaderName, String profileImage) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 5),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(profileImage),
      ),
      title: Text(
        leaderName,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  List<Widget> _buildMemberTiles() {
    return _memberRoles.keys.map((memberName) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/profile_pic.jpg'),
          ),
          title: Text(
            memberName,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: DropdownButton<String>(
            value: _memberRoles[memberName],
            items: ['Member', 'Admin'].map((role) {
              return DropdownMenuItem<String>(
                value: role,
                child: Text(
                  role,
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              );
            }).toList(),
            onChanged: (newRole) {
              setState(() {
                _memberRoles[memberName] = newRole!;
              });
            },
          ),
        ),
      );
    }).toList();
  }

  void _saveRoles() {
    // Implement the logic to save roles, e.g., make an API call to save the changes.
    // For now, we just print the roles to the console.
    print('Roles saved: $_memberRoles');
  }
}
