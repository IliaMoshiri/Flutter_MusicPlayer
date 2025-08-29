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



class Song {
  final String title;
  final String artist;
  final String assetPath;
  final String coverPath;
  int likes;
  final String price;

  Song({
    required this.title,
    required this.artist,
    required this.assetPath,
    required this.coverPath,
    this.likes = 0,
    required this.price,
  });
}



List<Song> localSongs = [
  Song(title: 'WTF', artist: "Hugel Delsa" , assetPath: 'wtf_hugel.mp3' , coverPath: 'assets/wtf.jpg' , likes: 8 , price: "free"),
  Song(title: 'FE!N', artist: 'Travis Scott' ,  assetPath: 'FE!N_Travis Scott, Playboi Carti.mp3' , coverPath: 'assets/fein.jpg' , likes: 10 , price: "free"),
  Song(title: 'Star Boy', artist: 'The Weekend' , assetPath: 'starboy.mp3' , coverPath: 'assets/starboyp.jpg' , likes: 5 , price: "free"),
  Song(title: 'Ahmagh', artist: 'Reza Golzar' , assetPath: 'AHMAGH (by @Arshiashi).mp3' , coverPath: 'assets/ahmagh.jpg' , likes: 20 , price: "free"),
  Song(title: 'Eyval', artist: 'Alireza JJ' , assetPath: 'Alireza JJ & Sijal & Nassim – Eyval Eyval.mp3' , coverPath: 'assets/ey val.jpg' , likes: 4 , price: "free"),
  Song(title: 'Goriz', artist: 'Ebi' , assetPath: '02 Goriz.mp3' , coverPath: 'assets/ebi.jpg' , likes: 20 , price: "free"),
];


List<Song> mySongs = [
  Song(title: 'Love Again', artist: 'Dua Lipa', assetPath: 'Love Again_Dua Lipa.mp3', coverPath: 'assets/loveagain.jpg', likes: 6 , price: "free"),
  Song(title: 'The Scotts', artist: 'Travis Scott & Kid Cudi', assetPath: 'the_scotts_kid.mp3', coverPath: 'assets/sickomode.jpg', price: "free" , likes: 7),
];


List<Song> AllMYSongs = [
  Song(title: 'WTF', artist: "Hugel Delsa" , assetPath: 'wtf_hugel.mp3' , coverPath: 'assets/wtf.jpg' , likes: 8 , price: "free"),
  Song(title: 'FE!N', artist: 'Travis Scott' ,  assetPath: 'FE!N_Travis Scott, Playboi Carti.mp3' , coverPath: 'assets/fein.jpg' , likes: 10 , price: "free"),
  Song(title: 'Star Boy', artist: 'The Weekend' , assetPath: 'starboy.mp3' , coverPath: 'assets/starboyp.jpg' , likes: 5 , price: "free"),
  Song(title: 'Love Again', artist: 'Dua Lipa', assetPath: 'Love Again_Dua Lipa.mp3', coverPath: 'assets/loveagain.jpg', likes: 6 , price: "free"),
  Song(title: 'The Scotts', artist: 'Travis Scott & Kid Cudi', assetPath: 'the_scotts_kid.mp3', coverPath: 'assets/sickomode.jpg', price: "free" , likes: 7),
  Song(title: 'Ahmagh', artist: 'Reza Golzar' , assetPath: 'AHMAGH (by @Arshiashi).mp3' , coverPath: 'assets/ahmagh.jpg' , likes: 20 , price: "free"),
  Song(title: 'Eyval', artist: 'Alireza JJ' , assetPath: 'Alireza JJ & Sijal & Nassim – Eyval Eyval.mp3' , coverPath: 'assets/ey val.jpg' , likes: 4 , price: "free"),
  Song(title: 'Goriz', artist: 'Ebi' , assetPath: '02 Goriz.mp3' , coverPath: 'assets/ebi.jpg' , likes: 20 , price: "free"),
];


List<Song> RockSongs = [
  Song(title: 'Going Under', artist: 'Evanescence', assetPath: '11_Going_Under_Evanescence.mp3', coverPath: 'assets/Picsart_25-05-22_22-59-22-696.jpg' , likes: 2 , price: "2.50"),
  Song(title: 'Black Betty', artist: 'Ram Jam', assetPath: 'Black Betty_Ram Jam.mp3', coverPath: 'assets/Picsart_25-05-22_22-59-22-696.jpg' , likes: 3, price: "3.99")
];


List<Song> HipHopSongs = [
  Song(title: 'Flashing Lights', artist: 'Drake', assetPath: 'Flashing_Lights_(feat. Dwele)_Kanye West.mp3', coverPath: 'assets/Picsart_25-05-22_23-01-19-759.jpg', price: '3.49' , likes: 4),
  Song(title: "Big Dawgs", artist: 'Hanu Mankind', assetPath: 'HanuMankind_Ft_Kalmi_Big_Dawgs_musicdel.ir.mp3', coverPath: 'assets/Picsart_25-05-22_23-01-19-759.jpg', price: '2.99' , likes: 2),
];


List<Song> PopSongs = [
  Song(title: 'Dreamers', artist: 'Savoir Adore', assetPath: '16_Dreamers_Savoir_Adore.mp3', coverPath: 'assets/Picsart_25-05-22_22-59-54-606.jpg', price: '4.30' , likes: 3),
  Song(title: 'Die Young', artist: 'Kesha', assetPath: 'Die Young_Kesha.mp3', coverPath: 'assets/Picsart_25-05-22_22-59-54-606.jpg', price: '1.99' , likes: 5),
  Song(title: 'Break My Heart', artist: 'Dua lipa', assetPath: 'Dua_Lipa_Break_My_Heart_dibamusics.mp3', coverPath: 'assets/Picsart_25-05-22_22-59-54-606.jpg', price: '6.00' , likes: 3),
];


List<Song> PersianSongs = [
  Song(title: 'Mano Yadet Nemiad', artist: 'Kasra Zahedi', assetPath: 'Kasra Zahedi_Mano Yadet Nemiad (128).mp3', coverPath: 'assets/Picsart_25-05-22_23-02-07-475.jpg', price: "7.39" , likes: 5),
  Song(title: 'Ahmagh', artist: 'Reza Golzar' , assetPath: 'AHMAGH (by @Arshiashi).mp3' , coverPath: 'assets/Picsart_25-05-22_23-02-07-475.jpg' , likes: 20 , price: "12.03"),
  Song(title: 'Eyval', artist: 'Alireza JJ' , assetPath: 'Alireza JJ & Sijal & Nassim – Eyval Eyval.mp3' , coverPath: 'assets/Picsart_25-05-22_23-02-07-475.jpg' , likes: 4 , price: "1.99"),
  Song(title: 'Goriz', artist: 'Ebi' , assetPath: '02 Goriz.mp3' , coverPath: 'assets/Picsart_25-05-22_23-02-07-475.jpg' , likes: 20 , price: "3.40"),
];


List<Song> ClassicSongs = [
  Song(title: 'Dreamers', artist: 'Savoir Adore', assetPath: '16_Dreamers_Savoir_Adore.mp3', coverPath: 'assets/Picsart_25-05-22_23-02-47-206.jpg', price: '4.30' , likes: 3),
  Song(title: 'Die Young', artist: 'Kesha', assetPath: 'Die Young_Kesha.mp3', coverPath: 'assets/Picsart_25-05-22_23-02-47-206.jpg', price: '1.99' , likes: 5),
  Song(title: 'Break My Heart', artist: 'Dua lipa', assetPath: 'Dua_Lipa_Break_My_Heart_dibamusics.mp3', coverPath: 'assets/Picsart_25-05-22_23-02-47-206.jpg', price: '6.00' , likes: 3),
];


List<Song> AllHipHop = [
  Song(title: 'FE!N', artist: 'Travis Scott' ,  assetPath: 'FE!N_Travis Scott, Playboi Carti.mp3' , coverPath: 'assets/Picsart_25-05-22_23-00-43-699.jpg' , likes: 10 , price: "free"),
  Song(title: 'The Scotts', artist: 'Travis Scott & Kid Cudi', assetPath: 'the_scotts_kid.mp3', coverPath: 'assets/Picsart_25-05-22_22-58-26-524.jpg', price: "free" , likes: 7),
  Song(title: 'Flashing Lights', artist: 'Drake', assetPath: 'Flashing_Lights_(feat. Dwele)_Kanye West.mp3', coverPath: 'assets/Picsart_25-05-22_23-01-19-759.jpg', price: '3.49' , likes: 4),
  Song(title: "Big Dawgs", artist: 'Hanu Mankind', assetPath: 'HanuMankind_Ft_Kalmi_Big_Dawgs_musicdel.ir.mp3', coverPath: 'assets/Picsart_25-05-22_23-01-19-759.jpg', price: '2.99' , likes: 2),
];


List<Song> AllPop = [
  Song(title: 'Dreamers', artist: 'Savoir Adore', assetPath: '16_Dreamers_Savoir_Adore.mp3', coverPath: 'assets/Picsart_25-05-22_22-59-54-606.jpg', price: '4.30' , likes: 3),
  Song(title: 'Die Young', artist: 'Kesha', assetPath: 'Die Young_Kesha.mp3', coverPath: 'assets/Picsart_25-05-22_22-59-54-606.jpg', price: '1.99' , likes: 5),
  Song(title: 'Break My Heart', artist: 'Dua lipa', assetPath: 'Dua_Lipa_Break_My_Heart_dibamusics.mp3', coverPath: 'assets/Picsart_25-05-22_22-59-54-606.jpg', price: '6.00' , likes: 3),
  Song(title: 'WTF', artist: "Hugel Delsa" , assetPath: 'wtf_hugel.mp3' , coverPath: 'assets/Picsart_25-05-22_23-00-43-699.jpg' , likes: 8 , price: "free"),
  Song(title: 'Star Boy', artist: 'The Weekend' , assetPath: 'starboy.mp3' , coverPath: 'assets/Picsart_25-05-22_23-00-43-699.jpg' , likes: 5 , price: "free"),
  Song(title: 'Love Again', artist: 'Dua Lipa', assetPath: 'Love Again_Dua Lipa.mp3', coverPath: 'assets/Picsart_25-05-22_22-58-26-524.jpg', likes: 6 , price: "free"),
];