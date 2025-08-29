import 'dart:convert';
import 'package:MOZX/config.dart';
import 'package:http/http.dart' as http;

class Comment {
  final String author;
  final String text;
  int likes;
  int dislikes;

  Comment({
    required this.author,
    required this.text,
    this.likes = 0,
    this.dislikes = 0,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      author: json['authorName'] ?? "Unknown",
      text: json['text'] ?? '',
      likes: (json['likes'] ?? 0) as int,
      dislikes: (json['dislikes'] ?? 0) as int,
    );
  }
}


Future<void> addComment(String songId, String text, int userId) async {
  final url = Uri.parse("$baseUrl/api/comments");
  print("Sending comment to: $url");

  try {
    final res = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "X-User-Id": userId.toString(),
      },
      body: jsonEncode({
        "songId": songId,
        "text": text,
      }),
    );

    print("Response status: ${res.statusCode}");
    print("Response body: ${res.body}");

    if (res.statusCode != 200) {
      throw Exception("HTTP Error: ${res.statusCode}, Body: ${res.body}");
    }
  } catch (e) {
    print("Full error: $e");
    rethrow;
  }
}


Future<List<Comment>> getComments(String songId) async {
  final url = Uri.parse("$baseUrl/api/shop/songs/$songId/comments");
  print("Fetching comments from: $url");

  final res = await http.get(url);

  if (res.statusCode == 200) {
    final List<dynamic> data = jsonDecode(res.body);
    print("Comment JSON: $data");
    return data.map((c) => Comment.fromJson(c)).toList();
  } else {
    throw Exception("HTTP Error: ${res.statusCode}, Body: ${res.body}");
  }
}
