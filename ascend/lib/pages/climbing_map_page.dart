import 'package:flutter/material.dart';

class ClimbingMapPage extends StatelessWidget {
  const ClimbingMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Climbing Map")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Climbing Map Content Goes Here"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the section or detailed view
              },
              child: const Text("View Details"),
            ),
          ],
        ),
      ),
    );
  }
}
