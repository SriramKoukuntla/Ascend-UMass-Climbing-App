import 'package:flutter/material.dart';

class Announcement {
  final String title;
  final String content;
  final DateTime posted;
  final String author;

  Announcement({
    required this.title,
    required this.content,
    required this.posted,
    required this.author,
  });
}

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  final List<Announcement> _announcements = [
    Announcement(
      title: "Ascend closed Monday",
      content: "Our gym will be closed for Veterans day. We will be open as usual on Tuesday!",
      posted: DateTime(2024, 11, 9),
      author: "John Doe",
    ),
    Announcement(
      title: "The backside wall has been changed!",
      content: "Our backside wall has been changed with 3 yellows, 2 oranges, and a red!",
      posted: DateTime(2023, 10, 29),
      author: "Jane Smith",
    ),
    Announcement(
      title: "Upcoming Underhang update",
      content: "The underhang is getting updated 1 week from today! Make sure to get your underhang climbs finished!",
      posted: DateTime(2023, 10, 22),
      author: "David Johnson",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Announcements"),
      ),
      body: ListView.builder(
        itemCount: _announcements.length,
        itemBuilder: (context, index) {
          final announcement = _announcements[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: InkWell(
              onTap: () {
                // Navigate to the announcement detail page
                _showAnnouncementDetails(announcement);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      announcement.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      announcement.content,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Posted by ${announcement.author}",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          "${announcement.posted.day}/${announcement.posted.month}/${announcement.posted.year}",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAnnouncementDetails(Announcement announcement) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(announcement.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(announcement.content),
              const SizedBox(height: 16.0),
              Text(
                "Posted by ${announcement.author} on ${announcement.posted.day}/${announcement.posted.month}/${announcement.posted.year}",
                style: TextStyle(color: Colors.grey[600]),
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
}