import 'package:flutter/material.dart';
import '/pages/home_page.dart';
import '/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ascend App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}





// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Ascend App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//         useMaterial3: true,
//       ),
//       home: const LoginPage(),
//     );
//   }
// }

// // Login Page with Staff and Non-Staff Options
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool isStaffLogin = false; // Track whether it is staff or non-staff login

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         // Gradient background
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/homepage.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'ASCEND',
//                 style: TextStyle(
//                   fontSize: 48,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   letterSpacing: 2.0,
//                 ),
//               ),
//               const SizedBox(height: 40),

//               // Toggle between Staff and Non-Staff login
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         isStaffLogin = false;
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: isStaffLogin
//                           ? Colors.white.withOpacity(0.7)
//                           : Colors.white.withOpacity(1),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       'Non-Staff',
//                       style: TextStyle(color: Colors.blue),
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         isStaffLogin = true;
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: isStaffLogin
//                           ? Colors.white.withOpacity(1)
//                           : Colors.white.withOpacity(0.7),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       'Staff',
//                       style: TextStyle(color: Colors.blue),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               // Username TextField
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const TextField(
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     labelText: 'Username',
//                     labelStyle: TextStyle(color: Colors.blue),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Password TextField
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     labelText: 'Password',
//                     labelStyle: TextStyle(color: Colors.blue),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // Dynamic Sign In Button (Staff or Non-Staff)
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Redirect to the app's main navigation page
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const HomePage()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white.withOpacity(1),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     isStaffLogin ? 'Sign In as Staff' : 'Sign In',
//                     style: const TextStyle(
//                       color: Colors.blue,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
                  
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Dynamic Sign Up Button (Staff / Non-Staff)
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Redirect to the app's main navigation page
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const HomePage()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white.withOpacity(1),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     isStaffLogin ? 'Sign Up as Staff' : 'Sign Up',
//                     style: const TextStyle(
//                       color: Colors.blue,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
                  
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Main App with Navigation for Climbing Gym App Features
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;

//   // List of pages corresponding to each tab in the bottom navigation bar
//   final List<Widget> _pages = [
//     const ClimbingMapPage(),
//     const VideosPage(),
//     const ForumPage(),
//     const AnalyticsPage(),
//     const AnnouncementsPage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.map),
//             label: 'Climbing Map',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.video_library),
//             label: 'Videos',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.forum),
//             label: 'Forum',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bar_chart),
//             label: 'Analytics',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.announcement),
//             label: 'Announcements',
//           ),
//         ],
//         selectedItemColor: Colors.blueAccent,
//         unselectedItemColor: const Color.fromARGB(255, 153, 182, 255),
//       ),
//     );
//   }
// }

// // Placeholder for Climbing Map Page
// class ClimbingMapPage extends StatelessWidget {
//   const ClimbingMapPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Climbing Map'),
//       ),
//       body: const Center(
//         child: Text(
//           'Top-down view of the climbing walls goes here',
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }

// // Placeholder for Videos Page
// class VideosPage extends StatelessWidget {
//   const VideosPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Videos'),
//       ),
//       body: const Center(
//         child: Text(
//           'Videos page for uploading and watching climbs',
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }

// // Placeholder for Forum Page
// class ForumPage extends StatelessWidget {
//   const ForumPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Forum'),
//       ),
//       body: const Center(
//         child: Text(
//           'Forum for discussion about climbs',
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }

// // Placeholder for Analytics Page
// class AnalyticsPage extends StatelessWidget {
//   const AnalyticsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Analytics & Leaderboard'),
//       ),
//       body: const Center(
//         child: Text(
//           'Peak hours and leaderboard go here',
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }


// // Placeholder for Announcements Page
// class AnnouncementsPage extends StatelessWidget {
//   const AnnouncementsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Announcements'),
//       ),
//       body: const Center(
//         child: Text(
//           'Gym announcements, wall changes, hours, etc.',
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }