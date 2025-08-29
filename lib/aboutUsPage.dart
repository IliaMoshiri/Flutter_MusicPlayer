import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'LogInPage.dart';
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


class WritePage extends StatefulWidget {
  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("About us"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          controller: _controller,
          maxLines: null,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "سلام ما ایلیا و سینا هستیم و این برنامه رو ساختیم اگه نظری برای بهتر شدنش داری به این ایدی ها تو تلگرام پیام بده@Sinaxrh1384 @Iliaamm",
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blueAccent),
            ),
          ),
        ),
      ),
    );
  }
}