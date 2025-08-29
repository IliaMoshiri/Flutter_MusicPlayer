import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Profile.dart';
import 'config.dart';
import 'Password.dart';
import 'MOZX.dart';
import 'SignupPage.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 20, 20),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 20, 20, 20),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('MOZX', style: GoogleFonts.redHatDisplay(fontWeight: FontWeight.w900, color: Colors.white,),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'LOG IN',
                style: GoogleFonts.interTight(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Enter Username or Email',
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[850],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              PasswordField(controller: passwordController),
              SizedBox(height: 20),
              SizedBox(
                width: 360,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    final emailOrUsername = usernameController.text.trim();
                    final password = passwordController.text.trim();

                    if (emailOrUsername.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please complete every field of the form' , style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                      return;
                    }

                    try {
                      final loginUrl = Uri.parse('$baseUrl/api/users/login');
                      final response = await http.post(
                        loginUrl,
                        headers: {'Content-Type': 'application/json'},
                        body: jsonEncode({
                          'email': emailOrUsername,
                          'password': password,
                        }),
                      );

                      if (response.statusCode == 200) {
                        final body = jsonDecode(response.body);
                        final userData = body['data'] ?? {};

                        UserData.isLoggedIn = true;
                        UserData.name = userData['name'] ?? '';
                        UserData.email = userData['email'] ?? '';
                        UserData.phone = userData['phoneNumber'] ?? '';
                        UserData.wallet = (userData['wallet']?.toString() ?? '0.00');

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Welcome back, ${UserData.name}!' , style: TextStyle(color: Colors.black),),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainMenuPage()),
                        );
                      } else {
                        final errorMsg = jsonDecode(response.body)['message'] ?? 'Login failed';
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login failed: $errorMsg' , style: TextStyle(color: Colors.white),),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Connection error: $e' , style: TextStyle(color: Colors.white),
                        ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: Text('Log in', style: GoogleFonts.redHatDisplay(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white,),),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: Text(
                  'forgot password?',
                  style: GoogleFonts.redHatDisplay(color: Colors.blue),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                child: Text(
                  'or sign up',
                  style: GoogleFonts.redHatDisplay(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
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




class UserData {
  static bool isLoggedIn = false;

  static String name = '';
  static String email = '';
  static String phone = '09123456789';
  static String wallet = '20.00';

  static void login({required String username, required String email}) {
    isLoggedIn = true;
    name = username;
    UserData.email = email;
  }

  static void logout() {
    isLoggedIn = false;
    name = '';
    email = '';
  }
}




