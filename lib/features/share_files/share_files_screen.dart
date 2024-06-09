import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remote_collab_tool/common/navbar/navbar.dart';
import 'package:remote_collab_tool/common/appbar/appbar.dart';
import 'package:remote_collab_tool/theme/pallete.dart';

class ShareFilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to history page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FileHistoryScreen()),
              );
            },
          ),
        ],
        title: Text('RTC', style: GoogleFonts.pacifico()),
        centerTitle: true,
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Handle file upload area tap
                },
                child: Container(
                  color: Pallete.bgColor, // Semi-transparent color
                  child: Center(
                    child: Icon(
                      Icons.file_upload,
                      size: 100,
                      color:
                          Pallete.headlineTextColor, // File upload icon color
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter file name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle send button press
                    },
                    child: Text("Send", style: GoogleFonts.pacifico()),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FileHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      appBar: AppBar(
        title: Text("File History", style: GoogleFonts.montserrat()),
      ),
      body: ListView.builder(
        itemCount: 5, // Example number of files
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(
                  "User"), // You can replace this with the actual user's initials or image
            ),
            title: Text("File ${index + 1}", style: GoogleFonts.montserrat()),
            subtitle: Text("File Type: ${index % 2 == 0 ? 'PDF' : 'DOC'}",
                style: GoogleFonts.montserrat()),
            trailing: IconButton(
              icon: Icon(Icons.open_in_new),
              onPressed: () {
                // Handle open button press
              },
            ),
          );
        },
      ),
    );
  }
}
