import 'package:flutter/material.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Videos")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Videos Section (Climb Videos) Goes Here"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the video player or upload section
              },
              child: const Text("Upload Video"),
            ),
          ],
        ),
      ),
    );
  }
}
