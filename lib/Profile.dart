import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'Password.dart';
import 'SignUpPage.dart';
import 'ShopPage.dart';
import 'MySongPage.dart';
import 'MOZX.dart';
import 'Profile.dart';
import 'NowPlayingPage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'PurchasePage.dart';
import 'ListOfSongs.dart';
import 'SearchPage.dart';
import 'song.dart';
import 'wallet.dart';
import 'dart:async';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 20, 20),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 20, 20, 20),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('MOZX', style: GoogleFonts.redHatDisplay(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              UserData.name,
              style: GoogleFonts.redHatDisplay(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'premium',
                style: GoogleFonts.redHatDisplay(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 30),
            _buildTextField(label: 'Gmail' , initialText: UserData.email),
            SizedBox(height: 15),
            _buildTextField(label: 'Phone number' , initialText: UserData.phone),
            SizedBox(height: 15),
            _buildTextField(label: 'Wallet' , initialText: UserData.wallet),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  UserData.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  'Log Out',
                  style: GoogleFonts.redHatDisplay(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTextField({required String label , required String initialText}) {
    return TextField(
      controller: TextEditingController(text: initialText),
      style: TextStyle(color: Colors.white),
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.redHatDisplay(color: Colors.white),
        filled: true,
        fillColor: Colors.black,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

}



