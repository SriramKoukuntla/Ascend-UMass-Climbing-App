import 'package:flutter/material.dart';

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
}

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  List<ForumPost> _posts = [
    ForumPost(
      id: 1,
      title: "Tips for Bouldering Beginners",
      content: "As a beginner in bouldering, here are some tips that helped me improve my skills...",
      author: "John Doe",
      createdAt: DateTime(2023, 5, 1),
      comments: [
        Comment(
          id: 1,
          content: "Great post! I found heel hooks to be really helpful when I started out.",
          author: "Jane Smith",
          createdAt: DateTime(2023, 5, 2),
        ),
        Comment(
          id: 2,
          content: "Agree with the tips. Listening to your body and taking breaks is so important.",
          author: "Bob Johnson",
          createdAt: DateTime(2023, 5, 3),
        ),
      ],
    ),
    ForumPost(
      id: 2,
      title: "Recommended Gear for Sport Climbing",
      content: "If you're getting into sport climbing, here are some must-have gear items...",
      author: "Sarah Lee",
      createdAt: DateTime(2023, 6, 15),
      comments: [
        Comment(
          id: 3,
          content: "Great list! I would also recommend investing in a good pair of climbing shoes.",
          author: "Michael Wong",
          createdAt: DateTime(2023, 6, 16),
        ),
        Comment(
          id: 4,
          content: "Definitely agree on the importance of a comfortable harness. Safety first!",
          author: "Emily Chen",
          createdAt: DateTime(2023, 6, 17),
        ),
      ],
    ),
    ForumPost(
      id: 3,
      title: "Advice for Climbing Competitions",
      content: "If you're gearing up for your first climbing competition, here are some tips...",
      author: "David Kim",
      createdAt: DateTime(2023, 7, 1),
      comments: [
        Comment(
          id: 5,
          content: "Great advice! Visualization and mental preparation are so important.",
          author: "Lisa Patel",
          createdAt: DateTime(2023, 7, 2),
        ),
        Comment(
          id: 6,
          content: "I found that staying hydrated and fueled helped me a lot during competitions.",
          author: "Alex Nguyen",
          createdAt: DateTime(2023, 7, 3),
        ),
        Comment(
          id: 7,
          content: "I found that staying hydrated and fueled helped me a lot during competitions.",
          author: "Alex Nguyen",
          createdAt: DateTime(2023, 7, 3),
        ),
        Comment(
          id: 8,
          content: "I found that staying hydrated and fueled helped me a lot during competitions.",
          author: "Alex Nguyen",
          createdAt: DateTime(2023, 7, 3),
        ),
        Comment(
          id: 9,
          content: "I found that staying hydrated and fueled helped me a lot during competitions.",
          author: "Alex Nguyen",
          createdAt: DateTime(2023, 7, 3),
        ),
        Comment(
          id: 10,
          content: "I found that staying hydrated and fueled helped me a lot during competitions.",
          author: "Alex Nguyen",
          createdAt: DateTime(2023, 7, 3),
        ),
        Comment(
          id: 11,
          content: "I found that staying hydrated and fueled helped me a lot during competitions.",
          author: "Alex Nguyen",
          createdAt: DateTime(2023, 7, 3),
        ),
        Comment(
          id: 12,
          content: "I found that staying hydrated and fueled helped me a lot during competitions.",
          author: "Alex Nguyen",
          createdAt: DateTime(2023, 7, 3),
        ),
        Comment(
          id: 1,
          content: "I found that staying hydrated and fueled helped me a lot during competitions.",
          author: "Alex Nguyen",
          createdAt: DateTime(2023, 7, 3),
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    // _loadPosts(); // Remove this line since we're using dummy data
  }

  Future<void> _createPost(String title, String content) async {
    // Implement post creation logic using the dummy data
    final newPost = ForumPost(
      id: _posts.length + 1,
      title: title,
      content: content,
      author: 'John Doe', // Replace with the current user's name
      createdAt: DateTime.now(),
      comments: [],
    );
    setState(() {
      _posts.add(newPost);
    });
  }

  Future<void> _addComment(ForumPost post, String content) async {
    // Implement comment addition logic using the dummy data
    final newComment = Comment(
      id: post.comments.length + 1,
      content: content,
      author: 'John Doe', // Replace with the current user's name
      createdAt: DateTime.now(),
    );
    setState(() {
      post.comments.add(newComment);
    });
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
      return Dialog(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          child: Scaffold(
            appBar: AppBar(
              title: Text(post.title),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
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
                                  const Divider(),
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
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showAddCommentDialog(post);
                },
                child: const Text("Add Comment"),
              ),
            ),
          ),
        ),
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