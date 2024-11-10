import 'package:flutter/material.dart';

class ClimbingMapPage extends StatelessWidget {
  const ClimbingMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapLayout = [
      ['E', 'E', 'M', 'E', 'M', 'E'],
      ['E', 'E', 'E', 'E', 'E', 'M'],
      ['E', 'M', 'M', 'E', 'E', 'E'],
      ['M', 'E', 'E', 'M', 'E', 'M'],
      ['E', 'M', 'M', 'E', 'E', 'E'],
      ['E', 'E', 'E', 'E', 'E', 'E'],
    ];

    String getCellText(int row, int col) {
      if (row == 0 && col == 2) return "Back L";
      if (row == 0 && col == 4) return "Back R";
      if (row == 1 && col == 5) return "Right B";
      if (row == 2 && col == 1) return "Island BL";
      if (row == 2 && col == 2) return "Island BR";
      if (row == 3 && col == 5) return "Right F";
      if (row == 3 && col == 0) return "Under hang";
      if (row == 3 && col == 3) return "Island R";
      if (row == 4 && col == 1) return "Island FL";
      if (row == 4 && col == 2) return "Island FR";
      return "";
    }

    String getCellImage(int row, int col) {
      String label = getCellText(row, col);
      label = label.replaceAll(' ', '_');
      return 'assets/$label.jpg';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Climbing Map"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: mapLayout.length * mapLayout[0].length,
          itemBuilder: (context, index) {
            int row = index ~/ 6;
            int col = index % 6;
            String cellType = mapLayout[row][col];

            String cellText = getCellText(row, col);
            String cellImage = getCellImage(row, col);

            return Container(
              color: cellType == 'M' ? Colors.transparent : Colors.transparent,
              child: Center(
                child: cellType == 'M'
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullscreenImagePage(
                                imagePath: cellImage,
                                climbName: cellText,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [Colors.blueAccent, Colors.lightBlueAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            cellText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}

class FullscreenImagePage extends StatefulWidget {
  final String imagePath;
  final String climbName;

  const FullscreenImagePage({Key? key, required this.imagePath, required this.climbName}) : super(key: key);

  @override
  _FullscreenImagePageState createState() => _FullscreenImagePageState();
}

class _FullscreenImagePageState extends State<FullscreenImagePage> {
  late ScrollController _horizontalController;
  late ScrollController _verticalController;

  @override
  void initState() {
    super.initState();
    _horizontalController = ScrollController();
    _verticalController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerImage();
    });
  }

  void _centerImage() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    _horizontalController.jumpTo((screenWidth * 2 - screenWidth) / 2);
    _verticalController.jumpTo((screenHeight * 2 - screenHeight) / 2);
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.climbName),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          controller: _horizontalController,
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            controller: _verticalController,
            scrollDirection: Axis.vertical,
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 3.0,
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * 2,
                height: MediaQuery.of(context).size.height * 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
