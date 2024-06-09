import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remote_collab_tool/theme/pallete.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Text("Sign Up",
                    style: GoogleFonts.poppins(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 17, 0, 6),
                    )),
              ),
              const SizedBox(
                height: 4,
              ),
              Center(
                child: Text("Happy to see new users! :D",
                    style: GoogleFonts.aldrich(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromARGB(255, 17, 0, 6),
                    )),
              ),
              const SizedBox(
                height: 4,
              ),
              GestureDetector(
                onTap: () {
                  // Implement profile picture selection functionality
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.pink[200],
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  fillColor: Colors.pink[50],
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  fillColor: Colors.pink[50],
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  fillColor: Colors.pink[50],
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  fillColor: Colors.pink[50],
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Text("Already a member? Sign in",
                      style: GoogleFonts.aldrich(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 14, 0, 66),
                      ))),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  // Implement sign-up functionality
                },
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Pallete.buttonColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.cherryCreamSoda(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
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
