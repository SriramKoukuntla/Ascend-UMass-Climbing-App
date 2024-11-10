import 'package:flutter/material.dart';

class ClimbingMapPage extends StatelessWidget {
  const ClimbingMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define a 6x6 grid with marked ('M') and empty ('E') cells
    final mapLayout = [
      ['E', 'E', 'M', 'E', 'M', 'E'],
      ['E', 'E', 'E', 'E', 'E', 'M'],
      ['E', 'M', 'M', 'E', 'E', 'E'],
      ['M', 'E', 'E', 'M', 'E', 'M'],
      ['E', 'M', 'M', 'E', 'E', 'E'],
      ['E', 'E', 'E', 'E', 'E', 'E'],
    ];

    // Function to get the label for each 'M' cell
    String getCellText(int row, int col) {
      if (row == 0 && col == 2) return "Back L";
      if (row == 0 && col == 4) return "Back R";
      if (row == 1 && col == 5) return "Right B";
      if (row == 2 && col == 1) return "Island BL";
      if (row == 2 && col == 2) return "Island BR";
      if (row == 3 && col == 5) return "Right F";
      if (row == 3 && col == 0) return "Underhang";
      if (row == 3 && col == 3) return "Island R";
      if (row == 4 && col == 1) return "Island FL";
      if (row == 4 && col == 2) return "Island FR";
      return ""; // For 'E' cells, no text is shown
    }

    // Function to get the image path for each 'M' cell
    String getCellImage(int row, int col) {
      String label = getCellText(row, col);
      // Replace spaces with underscores to match image names
      label = label.replaceAll(' ', '_');
      return 'assets/$label.jpg'; // Assumes images are named like "Back_L.jpg"
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Climbing Map"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6, // Grid has 6 columns (based on your mapLayout)
            crossAxisSpacing: 8.0, // Space between columns
            mainAxisSpacing: 8.0, // Space between rows
          ),
          itemCount: mapLayout.length * mapLayout[0].length, // Total cells in the grid
          itemBuilder: (context, index) {
            int row = index ~/ 6; // Row index based on the 6-column grid
            int col = index % 6;  // Column index
            String cellType = mapLayout[row][col];

            // Get the text for the current cell
            String cellText = getCellText(row, col);

            // Get the image path for the current cell
            String cellImage = getCellImage(row, col);

            return Container(
              color: cellType == 'M' ? const Color.fromARGB(255, 248, 248, 248) : Colors.transparent, // Color only for marked cells
              child: Center(
                child: cellType == 'M'
                    ? ElevatedButton(
                        onPressed: () {
                          // Navigate to fullscreen image view when the button is pressed
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullscreenImagePage(
                                imagePath: cellImage,
                                climbName: cellText, // Pass the climb name here
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // Square corners
                          ),
                          padding: EdgeInsets.zero, // No extra padding
                        ),
                        child: Text(
                          cellText, // Text on the button
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : null, // Empty cells have no button
              ),
            );
          },
        ),
      ),
    );
  }
}

// New page to display the image fullscreen
class FullscreenImagePage extends StatelessWidget {
  final String imagePath;
  final String climbName; // Store the climb name

  const FullscreenImagePage({Key? key, required this.imagePath, required this.climbName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(climbName), // Set the title to the climb name
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Close the fullscreen view when tapped
          },
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover, // Ensure the image covers the screen
            height: double.infinity,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
