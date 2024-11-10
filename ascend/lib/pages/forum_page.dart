import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForumPost {
  final int id;
  final String title;
  final String content;
  final String author;
  final DateTime createdAt;
  final List<Comment> comments;

  ForumPost({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
    required this.comments,
  });

  factory ForumPost.fromJson(Map<String, dynamic> json) {
    return ForumPost(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      author: json['author'],
      createdAt: DateTime.parse(json['createdAt']),
      comments: (json['comments'] as List<dynamic>)
          .map((comment) => Comment.fromJson(comment))
          .toList(),
    );
  }
}

class Comment {
  final int id;
  final String content;
  final String author;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.content,
    required this.author,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      author: json['author'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  List<ForumPost> _posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final response = await http.get(Uri.parse('https://your-api.com/posts'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      setState(() {
        _posts = data.map((post) => ForumPost.fromJson(post)).toList();
      });
    } else {
      // Handle error
    }
  }

  Future<void> _createPost(String title, String content) async {
    final response = await http.post(
      Uri.parse('https://your-api.com/posts'),
      body: jsonEncode({
        'title': title,
        'content': content,
        'author': 'John Doe', // Replace with the current user's name
        'createdAt': DateTime.now().toIso8601String(),
        'comments': [],
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      _loadPosts();
    } else {
      // Handle error
    }
  }

  Future<void> _addComment(ForumPost post, String content) async {
    final response = await http.post(
      Uri.parse('https://your-api.com/posts/${post.id}/comments'),
      body: jsonEncode({
        'content': content,
        'author': 'John Doe', // Replace with the current user's name
        'createdAt': DateTime.now().toIso8601String(),
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      _loadPosts();
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forum"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: InkWell(
                    onTap: () {
                      _showPostDetails(post);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            post.content,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            "Posted by ${post.author} on ${post.createdAt.day}/${post.createdAt.month}/${post.createdAt.year}",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showCreatePostDialog();
              },
              child: const Text("Create New Post"),
            ),
          ),
        ],
      ),
    );
  }

  void _showPostDetails(ForumPost post) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(post.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(post.content),
              const SizedBox(height: 16.0),
              Text(
                "Posted by ${post.author} on ${post.createdAt.day}/${post.createdAt.month}/${post.createdAt.year}",
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16.0),
              if (post.comments.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Comments:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    ...post.comments.map((comment) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment.content,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              "Posted by ${comment.author} on ${comment.createdAt.day}/${comment.createdAt.month}/${comment.createdAt.year}",
                              style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                            ),
                            const SizedBox(height: 8.0),
                          ],
                        )),
                  ],
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
            TextButton(
              onPressed: () {
                _showAddCommentDialog(post);
              },
              child: const Text("Add Comment"),
            ),
          ],
        );
      },
    );
  }

  void _showCreatePostDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Create New Post"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: contentController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Content",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _createPost(titleController.text, contentController.text);
                Navigator.of(context).pop();
              },
              child: const Text("Create"),
            ),
          ],
        );
      },
    );
  }

  void _showAddCommentDialog(ForumPost post) {
    final commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Comment"),
          content: TextField(
            controller: commentController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: "Comment",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _addComment(post, commentController.text);
                Navigator.of(context).pop();
              },
              child: const Text("Post"),
            ),
          ],
        );
      },
    );
  }
}