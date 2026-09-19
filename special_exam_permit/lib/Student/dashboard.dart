import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

import 'package:special_exam_permit/Student/page/student_home_page.dart';
import 'package:special_exam_permit/Student/page/student_profile_page.dart';

import 'package:special_exam_permit/Student/page/student_requests_page.dart';
import 'package:special_exam_permit/pages/request_form_page.dart';

import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  List<Widget> get _pages => [
    StudentHomePage(
      onRequestTap: () {
        setState(() {
          _currentIndex = 1;
        });
      },
    ),

    const ExamRequestPage(),

    const StudentRequestsPage(),

    const StudentProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),

      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        backgroundColor: UMTheme.maroon,
        foregroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          'ExamFlow',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),

        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),

      // =========================
      // PAGE CONTENT
      // =========================
      body: IndexedStack(index: _currentIndex, children: _pages),

      // =========================
      // CURVED NAVIGATION BAR
      // =========================
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 65,

        backgroundColor: const Color(0xFFF5F6F8),

        color: UMTheme.maroon,

        buttonBackgroundColor: UMTheme.maroon,

        animationDuration: const Duration(milliseconds: 300),

        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined, color: Colors.white),
            label: 'Home',
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),

          CurvedNavigationBarItem(
            child: Icon(Icons.edit_document, color: Colors.white),
            label: 'Request',
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),

          CurvedNavigationBarItem(
            child: Icon(Icons.description_outlined, color: Colors.white),
            label: 'My Requests',
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),

          CurvedNavigationBarItem(
            child: Icon(Icons.person_outline, color: Colors.white),
            label: 'Profile',
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  // =========================
  // LOGOUT DIALOG
  // =========================

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          title: const Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: UMTheme.maroon,
            ),
          ),

          content: const Text('Are you sure you want to logout?'),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: UMTheme.maroon,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
