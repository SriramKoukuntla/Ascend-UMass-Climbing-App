import 'package:flutter/material.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forum")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Forum Content (Discussions) Goes Here"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to discussion threads or new post section
              },
              child: const Text("Create New Post"),
            ),
          ],
        ),
      ),
    );
  }
}
