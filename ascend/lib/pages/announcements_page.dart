import 'package:flutter/material.dart';

class AnnouncementsPage extends StatelessWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Announcements")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Announcements (Updates, Hours, etc.) Go Here"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the announcements detail page
              },
              child: const Text("View All Announcements"),
            ),
          ],
        ),
      ),
    );
  }
}
