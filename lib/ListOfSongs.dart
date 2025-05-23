import 'Password.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'PurchasePage.dart';

class CategorySongPage extends StatefulWidget {
  final String category;
  final List<Song> songs;

  const CategorySongPage({super.key, required this.category, required this.songs});

  @override
  State<CategorySongPage> createState() => _CategorySongPageState();
}

class _CategorySongPageState extends State<CategorySongPage> {
  late List<Song> displayedSongs;

  @override
  void initState() {
    super.initState();
    displayedSongs = widget.songs;
  }

  void sortSongs(String criteria) {
    setState(() {
      if (criteria == 'likes') {
        displayedSongs.sort((a, b) => b.likes.compareTo(a.likes));
      } else if (criteria == 'price') {
        displayedSongs.sort((a, b) => a.price.compareTo(b.price));
      } else if (criteria == 'name') {
        displayedSongs.sort((a, b) => a.title.compareTo(b.title));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
        title: Text(widget.category, style: GoogleFonts.redHatDisplay(fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.sort, color: Colors.white),
            onSelected: sortSongs,
            itemBuilder: (context) => [
              PopupMenuItem(value: 'likes', child: Text('Sort by Likes')),
              PopupMenuItem(value: 'price', child: Text('Sort by Price')),
              PopupMenuItem(value: 'name', child: Text('Sort by Name')),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: displayedSongs.length,
        itemBuilder: (context, index) {
          final song = displayedSongs[index];
          return ListTile(
            leading: Image.asset(song.coverPath, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(song.title, style: GoogleFonts.redHatDisplay(color: Colors.white)),
            subtitle: Text(song.artist, style: GoogleFonts.redHatDisplay(color: Colors.white70)),
            trailing: Text('\$${double.tryParse(song.price)?.toStringAsFixed(2) ?? "FREE"}', style: TextStyle(color: Colors.white),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PurchasePage(song: song),
                ),
              );
            },
          );
        },
      ),
    );
  }
}