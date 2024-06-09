import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:remote_collab_tool/common/navbar/navbar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(),
      backgroundColor: Colors.pink[50],
      body: Stack(
        children: [
          // Smoke radiowave particles animation
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: SpinKitRipple(
                color: Colors.white,
                size: 600.0,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Circle Avatar
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(
                      'https://media.discordapp.net/attachments/1248667871954079917/1249434675932434462/image.png?ex=66674a38&is=6665f8b8&hm=cb9ec2fce2c5ffbeae3d78ff6ecb7c7918a86273894f145900795e739108c1f2&=&format=webp&quality=lossless&width=477&height=453'),
                  backgroundColor: Colors.white.withOpacity(0.4),
                ),
                SizedBox(height: 20.0),
                // User Name
                Text(
                  'FireSquad',
                  style: GoogleFonts.pacifico(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent,
                  ),
                ),
                SizedBox(height: 10.0),
                // User Email
                Text(
                  'firesquad@hackjps.com',
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    color: Colors.pinkAccent,
                  ),
                ),
                SizedBox(height: 10.0),
                // Company Name
                Text(
                  'Works at: Google',
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    color: Colors.pinkAccent,
                  ),
                ),
                SizedBox(height: 40.0),
                // Neon Glowing Button
                GestureDetector(
                  onTap: () {
                    // Handle button tap
                  },
                  child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(
                        colors: [
                          Colors.pinkAccent,
                          Colors.purpleAccent,
                          Colors.blueAccent,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent.withOpacity(0.6),
                          spreadRadius: 4,
                          blurRadius: 20,
                          offset: Offset(0, 0),
                        ),
                        BoxShadow(
                          color: Colors.purpleAccent.withOpacity(0.6),
                          spreadRadius: 4,
                          blurRadius: 20,
                          offset: Offset(0, 0),
                        ),
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.6),
                          spreadRadius: 4,
                          blurRadius: 20,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'View Stats',
                        style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
