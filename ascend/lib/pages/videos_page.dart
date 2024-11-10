import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClimbingRoute {
  final String name;
  final String grade;
  final List<String> attributes;
  bool isCompleted;

  ClimbingRoute({
    required this.name,
    required this.grade,
    required this.attributes,
    this.isCompleted = false,
  });

  Color get gradeColor {
    // First check for V10+ explicitly
    if (grade.startsWith("V10") || grade.contains("V10+")) return Colors.black;
    
    // Then check other grades
    if (grade.startsWith("V0") || grade.startsWith("V1")) return const Color(0xFF006400); // Dark green
    if (grade.startsWith("V2") || grade.startsWith("V3")) return const Color(0xFF00008B); // Blue
    if (grade.startsWith("V4") || grade.startsWith("V5")) return const Color(0xFFFFD700); // Yellow
    if (grade.startsWith("V6") || grade.startsWith("V7")) return const Color(0xFFFF8C00); // Orange
    if (grade.startsWith("V8") || grade.startsWith("V9")) return const Color(0xFFFF0000); // Red
    
    return Colors.black; // Default to black for any unmatched grades
  }

  Future<void> loadCompletionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isCompleted = prefs.getBool('route_${name}_completed') ?? false;
  }

  Future<void> saveCompletionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('route_${name}_completed', isCompleted);
  }
}

class ClimbingListPage extends StatefulWidget {
  const ClimbingListPage({Key? key}) : super(key: key);

  @override
  State<ClimbingListPage> createState() => _ClimbingListPageState();
}

class _ClimbingListPageState extends State<ClimbingListPage> {
  final List<String> attributes = [
    'All', 'Crimps', 'Jugs', 'Slopers', 'Dyno', 'Pinches', 'Compression', 
    'Sidepulls', 'Technical',
  ];

  final List<Map<String, dynamic>> gradeGroups = [
    {"name": "V0-V1", "color": Color(0xFF006400), "selected": true},
    {"name": "V2-V3", "color": Color(0xFF00008B), "selected": true},
    {"name": "V4-V5", "color": Color(0xFFFFD700), "selected": true},
    {"name": "V6-V7", "color": Color(0xFFFF8C00), "selected": true},
    {"name": "V8-V9", "color": Color(0xFFFF0000), "selected": true},
    {"name": "V10+", "color": Colors.black, "selected": true},
  ];

  String _selectedAttribute = 'All';

  // Helper function to get numeric value of grade for sorting
  int _getGradeValue(String grade) {
    if (grade.startsWith("V10")) return 10;
    if (grade.contains("-")) {
      // For grades like "V2-V3", use the lower number
      return int.parse(grade.substring(1, 2));
    }
    // For single grades like "V4"
    return int.parse(grade.substring(1, 2));
  }

  // Sorted list of routes
  final List<ClimbingRoute> routes = [
    ClimbingRoute(
      name: "Balance Beam",
      grade: "V0-V1",
      attributes: ['Balance', 'Technical', 'Footwork'],
    ),
    ClimbingRoute(
      name: "Crimp Crusher",
      grade: "V2-V3",
      attributes: ['Crimps', 'Technical', 'Slopers'],
    ),
    ClimbingRoute(
      name: "Heel Hook Heaven",
      grade: "V2-V3",
      attributes: ['Heel Hook', 'Balance', 'Footwork'],
    ),
    ClimbingRoute(
      name: "Dyno King",
      grade: "V4-V5",
      attributes: ['Dyno', 'Powerful', 'Jugs'],
    ),
    ClimbingRoute(
      name: "Pinch Power",
      grade: "V4-V5",
      attributes: ['Pinches', 'Compression', 'Endurance'],
    ),
    ClimbingRoute(
      name: "Slab Master",
      grade: "V6-V7",
      attributes: ['Slab', 'Footwork', 'Sidepulls'],
    ),
    ClimbingRoute(
      name: "Reach for the Sky",
      grade: "V6-V7",
      attributes: ['Reachy', 'Sidepulls', 'High Step'],
    ),
    ClimbingRoute(
      name: "Overhang Beast",
      grade: "V8-V9",
      attributes: ['Overhang', 'Strength', 'Compression'],
    ),
    ClimbingRoute(
      name: "Big Moves",
      grade: "V8-V9",
      attributes: ['Dyno', 'Powerful', 'High Step'],
    ),
    ClimbingRoute(
      name: "Smooth Operator",
      grade: "V10+",
      attributes: ['Technical', 'Smooth', 'Balance'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Sort routes by grade
    routes.sort((a, b) => _getGradeValue(a.grade).compareTo(_getGradeValue(b.grade)));
    _loadCompletionStatuses();
  }

  Future<void> _loadCompletionStatuses() async {
    for (var route in routes) {
      await route.loadCompletionStatus();
    }
    setState(() {});
  }

  void _showRouteDialog(BuildContext context, ClimbingRoute route) {
    // Helper function to determine if a color is dark
    bool isDarkColor(Color color) {
      // Calculate relative luminance using standard formula
      double luminance = (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
      return luminance < 0.5;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(route.name),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "Grade: ${route.grade}",
                        style: TextStyle(
                          fontSize: 16,
                          color: route.gradeColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: route.attributes.map((attr) => Chip(
                      label: Text(attr),
                      backgroundColor: Colors.grey[200],
                    )).toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: route.isCompleted,
                        activeColor: route.gradeColor,
                        onChanged: (bool? value) {
                          setDialogState(() {
                            route.isCompleted = value ?? false;
                          });
                          route.saveCompletionStatus();
                          setState(() {});
                        },
                      ),
                      const Text("Mark as Completed", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement video upload
                        },
                        icon: Icon(
                          Icons.upload,
                          color: isDarkColor(route.gradeColor) ? Colors.white : Colors.black,
                        ),
                        label: Text(
                          "Upload\nVideo",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDarkColor(route.gradeColor) ? Colors.white : Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: route.gradeColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement video viewing
                        },
                        icon: Icon(
                          Icons.play_circle_filled,
                          color: isDarkColor(route.gradeColor) ? Colors.white : Colors.black,
                        ),
                        label: Text(
                          "View\nVideos",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDarkColor(route.gradeColor) ? Colors.white : Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: route.gradeColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close', style: TextStyle(color: route.gradeColor)),
            ),
          ],
        );
      },
    );
  }

  bool _isGradeSelected(String grade) {
    for (var group in gradeGroups) {
      if (group["selected"]) {
        if (group["name"] == "V10+" && grade.startsWith("V10")) {
          return true;
        } else if (grade.startsWith(group["name"].split("-")[0])) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Climbing Routes'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Column(
        children: [
          // Centered grade legend with selectable chips and overflow handling
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    alignment: WrapAlignment.center,
                    children: gradeGroups.map((group) {
                      return FilterChip(
                        label: _buildGradeLegend(group["name"], group["color"]),
                        selected: group["selected"],
                        onSelected: (bool selected) {
                          setState(() {
                            group["selected"] = selected;
                          });
                        },
                        backgroundColor: Colors.grey[200],
                        selectedColor: group["color"].withOpacity(0.3),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          // Attribute filter chips without horizontal scrolling, centered with overflow handling
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.center,
                children: attributes.map((attr) {
                  return FilterChip(
                    label: Text(attr),
                    selected: _selectedAttribute == attr,
                    onSelected: (selected) {
                      setState(() {
                        _selectedAttribute = selected ? attr : 'All';
                      });
                    },
                    selectedColor: Colors.grey[300],
                  );
                }).toList(),
              ),
            ),
          ),
          // Routes list
          Expanded(
            child: ListView.builder(
              itemCount: routes.where((route) =>
                (_selectedAttribute == 'All' || route.attributes.contains(_selectedAttribute)) &&
                _isGradeSelected(route.grade)
              ).length,
              itemBuilder: (context, index) {
                final filteredRoutes = routes.where((route) =>
                  (_selectedAttribute == 'All' || route.attributes.contains(_selectedAttribute)) &&
                  _isGradeSelected(route.grade)
                ).toList();
                final route = filteredRoutes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    leading: Icon(
                      route.isCompleted ? Icons.check_circle : Icons.circle_outlined,
                      color: route.isCompleted ? route.gradeColor : Colors.grey,
                    ),
                    title: Text(
                      route.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: route.gradeColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              route.grade,
                              style: TextStyle(
                                color: route.gradeColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 4,
                          children: route.attributes.map((attr) =>
                            Text(attr, style: TextStyle(color: Colors.grey[600]))
                          ).toList(),
                        ),
                      ],
                    ),
                    onTap: () => _showRouteDialog(context, route),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeLegend(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}