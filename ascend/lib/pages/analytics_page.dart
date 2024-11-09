import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analytics")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Analytics (Peak Hours, etc.) Goes Here"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to a detailed analysis page
              },
              child: const Text("View Analytics"),
            ),
          ],
        ),
      ),
    );
  }
}
