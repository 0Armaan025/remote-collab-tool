import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remote_collab_tool/employee/home_screen/employee_home_screen.dart';
import 'package:remote_collab_tool/employer/home_screen/employer_home_screen.dart';
import 'package:remote_collab_tool/global.dart';
import 'package:remote_collab_tool/constants/utils/utils.dart';
import 'package:remote_collab_tool/theme/pallete.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

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
                child: Text("Sign In",
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
                child: Text("Happy to welcome you back! :D",
                    style: GoogleFonts.aldrich(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromARGB(255, 17, 0, 6),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
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
              Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      moveScreen(context: context, widget: SignInPage());
                    },
                    child: Text("Already a member? Sign in",
                        style: GoogleFonts.aldrich(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(255, 14, 0, 66),
                        )),
                  )),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () async {
                  try {
                    UserCredential auth = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text);
                    FirebaseFirestore.instance
                        .collection("user")
                        .doc(auth.user!.uid)
                        .get()
                        .then((value) {
                      Map<String, dynamic> data = value.data()!;
                      if (data["role"] == "Employer") {
                        sharedPreferences!.setString("uid", auth.user!.uid);
                        sharedPreferences!
                            .setString("orgID", data["orgainizationID"]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => EmployerHomeScreen()));
                      } else {
                        sharedPreferences!.setString("uid", auth.user!.uid);
                        sharedPreferences!
                            .setString("orgID", data["orgainizationID"]);

                        sharedPreferences!.setString("role", "Employee");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => EmployeeHomeScreen()));
                      }
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Pallete.buttonColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'Sign in',
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
