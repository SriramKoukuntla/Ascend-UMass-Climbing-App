import 'package:flutter/material.dart';

class RankedPage extends StatelessWidget {
  const RankedPage();
  // Non-constant leaderboard data
  static const List<Map<String, dynamic>> leaderboard = [
    {'rank': 1, 'name': 'Sid', 'score': 1500},
    {'rank': 2, 'name': 'Min', 'score': 1400},
    {'rank': 3, 'name': 'Ram', 'score': 1300},
    {'rank': 4, 'name': 'Aaron', 'score': 1200},
    {'rank': 5, 'name': 'HappyClimber96', 'score': 1100},
  ];
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ranked Leaderboard")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: leaderboard.length,
              itemBuilder: (context, index) {
                final player = leaderboard[index];

                // Highlight top 3 ranks differently
                TextStyle rankStyle;
                if (player['rank'] == 1) {
                  rankStyle = const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.amber, // Gold for rank 1
                  );
                } else if (player['rank'] == 2) {
                  rankStyle = const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey, // Silver for rank 2
                  );
                } else if (player['rank'] == 3) {
                  rankStyle = const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.brown, // Bronze for rank 3
                  );
                } else {
                  rankStyle = const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  );
                }

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: InkWell(
                    onTap: () {
                      // Navigate to the detailed page
                      _showRankDetails(context, player);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rank ${player['rank']}',
                            style: rankStyle,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            player['name'],
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Score: ${player['score']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Full Leaderboard Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to a page showing the full leaderboard
                _showFullLeaderboard(context);
              },
              child: const Text("View Full Leaderboard"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                minimumSize: const Size(double.infinity, 0), // Full width button
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRankDetails(BuildContext context, Map<String, dynamic> player) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rank ${player['rank']} - ${player['name']}'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Score: ${player['score']}',
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Player Details go here...',
                style: const TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showFullLeaderboard(BuildContext context) {
    // Implement the navigation to the full leaderboard page here
    // For now, we just show a message for demonstration purposes
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Full Leaderboard"),
          content: const Text("Here will be the full leaderboard."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}