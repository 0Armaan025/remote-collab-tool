import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remote_collab_tool/theme/pallete.dart';

class EmployeeCompanyJoinInScreen extends StatefulWidget {
  const EmployeeCompanyJoinInScreen({super.key});

  @override
  State<EmployeeCompanyJoinInScreen> createState() =>
      _EmployeeCompanyJoinInScreenState();
}

class _EmployeeCompanyJoinInScreenState
    extends State<EmployeeCompanyJoinInScreen> {
  final _companyCodeController = TextEditingController();

  @override
  void dispose() {
    _companyCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Join Your Company",
                        style: GoogleFonts.pacifico(
                          fontSize: 30,
                          color: Color(0xFFE91E63),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Enter your company code below",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Color(0xFFE91E63),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _companyCodeController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Company Code',
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          // Handle company code submission
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 15.0),
                          shadowColor: Colors.black38,
                          elevation: 5,
                        ),
                        child: Text(
                          "Join in ->",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
