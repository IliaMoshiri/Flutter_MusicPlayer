import 'Password.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'MySongPage.dart';


class PurchasePage extends StatefulWidget {
  final Song song;
  const PurchasePage({Key? key, required this.song}) : super(key: key);

  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {

  int _rating = 0;

  double _downloadProgress = 0;

  bool _isDownloading = false;
  bool _downloaded = false;

  List<Comment> _comments = [
    Comment(author: 'Hashem', text: 'Very good song!', likes: 1),
    Comment(author: 'Sara', text: 'nice'),
  ];
  final TextEditingController _commentController = TextEditingController();


  void _startDownload() {
    if (_downloaded) return;
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0;
    });

    Future.doWhile(() async {
      await Future.delayed(Duration(milliseconds: 200));
      setState(() {
        _downloadProgress += 0.05;
        if (_downloadProgress >= 1) {
          _downloadProgress = 1;
          _isDownloading = false;
          _downloaded = true;
        }
      });
      return _isDownloading;
    });
  }


  void _postComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty || !_downloaded) return;
    setState(() {
      _comments.insert(0, Comment(author: 'You', text: text));
      _commentController.clear();
    });
  }

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
        centerTitle: true,
        title: Text('MOZX', style: GoogleFonts.redHatDisplay(color: Colors.white , fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.music_note_rounded, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MySongPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(widget.song.coverPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.song.title, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      Text(widget.song.artist, style: TextStyle(color: Colors.grey[300], fontSize: 16)),
                      SizedBox(height: 8),
                      Text('\$${double.tryParse(widget.song.price)?.toStringAsFixed(2) ?? "0.00"}'),
                      SizedBox(height: 12),
                      Row(
                        children: List.generate(5, (i) {
                          return IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              i < _rating ? Icons.favorite : Icons.favorite_border,
                              color: i < _rating ? Colors.red : Colors.white,
                            ),
                            onPressed: _downloaded
                                ? () {
                              setState(() => _rating = i + 1);
                            }
                                : null,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
            _isDownloading
                ? LinearProgressIndicator(value: _downloadProgress, backgroundColor: Colors.grey)
                : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: _startDownload,
              child: Text(
                _downloaded ? 'Downloaded' : 'BUY AND DOWNLOAD',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            SizedBox(height: 24),
            Divider(color: Colors.grey),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    enabled: _downloaded,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: _downloaded ? 'Comment...' : 'Purchase to comment',
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: _downloaded ? Colors.white : Colors.grey),
                  onPressed: _downloaded ? _postComment : null,
                ),
              ],
            ),
            SizedBox(height: 16),

            ..._comments.map((cmt) {
              return ListTile(
                leading: CircleAvatar(child: Text(cmt.author[0])),
                title: Text(cmt.author, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text(cmt.text, style: TextStyle(color: Colors.white70)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${cmt.likes}', style: TextStyle(color: Colors.white)),
                    IconButton(
                      icon: Icon(Icons.thumb_up, color: Colors.white, size: 20),
                      onPressed: () => setState(() => cmt.likes++),
                    ),
                    Text('${cmt.dislikes}', style: TextStyle(color: Colors.white)),
                    IconButton(
                      icon: Icon(Icons.thumb_down, color: Colors.white, size: 20),
                      onPressed: () => setState(() => cmt.dislikes++),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}