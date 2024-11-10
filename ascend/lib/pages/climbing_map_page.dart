import 'package:ascend/pages/list_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Hotspot {
  final Rect relativeRect;
  final String climbId;
  final String name;
  final String linkedRouteName;

  Hotspot({
    required this.relativeRect,
    required this.climbId,
    required this.name,
    required this.linkedRouteName,
  });
}

class ClimbingMapPage extends StatelessWidget {
  const ClimbingMapPage({Key? key}) : super(key: key);

  Map<String, List<Hotspot>> getHotspots() {
    return {
      'Back_L': [
        Hotspot(
          relativeRect: const Rect.fromLTWH(0.4, 0.3, 0.3, 0.4),
          climbId: '32',
          name: 'Reach for the Sky',
          linkedRouteName: 'Reach for the Sky',
        ),
        Hotspot(
          relativeRect: const Rect.fromLTWH(0.5, 0.2, 0.1, 0.1),
          climbId: '33',
          name: 'Balance Beam',
          linkedRouteName: 'Balance Beam',
        ),
      ],
      'Back_R': [
        Hotspot(
          relativeRect: const Rect.fromLTWH(0.1, 0.1, 0.4, 0.5),
          climbId: 'backr_1',
          name: 'Back Right Route 1',
          linkedRouteName: '',
        ),
      ],
      'Island_BR': [
        Hotspot(
          relativeRect: const Rect.fromLTWH(0.45, 0.45, 0.4, 0.5),
          climbId: '45',
          name: 'Dyno King',
          linkedRouteName: 'Dyno King',
        ),
      ],
      // Add more hotspots as needed
    };
  }

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

    final hotspotMap = getHotspots();

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
          physics: const NeverScrollableScrollPhysics(),
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
            String normalizedKey = cellText.replaceAll(' ', '_');
            
            List<Hotspot> cellHotspots = hotspotMap[normalizedKey] ?? [];

            return Container(
              color: Colors.transparent,
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
                                hotspots: cellHotspots,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                              colors: [Colors.blueAccent, Colors.lightBlueAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              cellText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 0.5,
                              ),
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
  final List<Hotspot> hotspots;

  const FullscreenImagePage({
    Key? key,
    required this.imagePath,
    required this.climbName,
    this.hotspots = const [],
  }) : super(key: key);

  @override
  _FullscreenImagePageState createState() => _FullscreenImagePageState();
}

class _FullscreenImagePageState extends State<FullscreenImagePage> {
  late ScrollController _horizontalController;
  late ScrollController _verticalController;
  late TransformationController _transformationController;
  final GlobalKey _imageKey = GlobalKey();
  Size? _imageSize;
  bool _showDebugOverlay = false;

  @override
  void initState() {
    super.initState();
    _horizontalController = ScrollController();
    _verticalController = ScrollController();
    _transformationController = TransformationController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerImage();
      _updateImageSize();
    });
  }

  void _updateImageSize() {
    final RenderBox? renderBox = _imageKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _imageSize = renderBox.size;
      });
    }
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
    _transformationController.dispose();
    super.dispose();
  }

  void _handleHotspotTap(BuildContext context, Hotspot hotspot) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(hotspot.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Climb ID: ${hotspot.climbId}'),
          if (hotspot.linkedRouteName.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text('Linked to route: ${hotspot.linkedRouteName}'),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        if (hotspot.linkedRouteName.isNotEmpty)
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close fullscreen image
              
              // Navigate to list page and show route dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClimbingListPage(
                    initialRouteName: hotspot.linkedRouteName,
                    shouldShowRouteDialog: true, // Add this parameter
                  ),
                ),
              );
            },
            child: const Text('View in List'),
          ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.climbName),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(_showDebugOverlay ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => _showDebugOverlay = !_showDebugOverlay),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          controller: _horizontalController,
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            controller: _verticalController,
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [
                InteractiveViewer(
                  transformationController: _transformationController,
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 3.0,
                  onInteractionUpdate: (_) => setState(() {}),
                  child: Image.asset(
                    widget.imagePath,
                    key: _imageKey,
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 2,
                    height: MediaQuery.of(context).size.height * 2,
                  ),
                ),
                if (_imageSize != null)
                  ...widget.hotspots.map((hotspot) {
                    final Matrix4 transform = _transformationController.value;
                    final double scale = transform.getMaxScaleOnAxis();
                    
                    final rect = Rect.fromLTWH(
                      _imageSize!.width * hotspot.relativeRect.left * scale + transform.entry(0, 3),
                      _imageSize!.height * hotspot.relativeRect.top * scale + transform.entry(1, 3),
                      _imageSize!.width * hotspot.relativeRect.width * scale,
                      _imageSize!.height * hotspot.relativeRect.height * scale,
                    );

                    return Positioned.fromRect(
                      rect: rect,
                      child: GestureDetector(
                        onTap: () => _handleHotspotTap(context, hotspot),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _showDebugOverlay 
                              ? Colors.red.withOpacity(0.3) 
                              : Colors.transparent,
                            border: _showDebugOverlay 
                              ? Border.all(color: Colors.red, width: 2) 
                              : null,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}