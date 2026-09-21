import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:special_exam_permit/admin/page/dashboard_page.dart';
import 'package:special_exam_permit/admin/page/exam_information_page.dart';
import 'package:special_exam_permit/admin/page/profile_page.dart';
import 'package:special_exam_permit/admin/page/requests_page.dart';
import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';
import 'package:special_exam_permit/service/exam_info_service.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  final CrudExamInfoService _examInfoService = CrudExamInfoService();
  int _currentIndex = 0;

  List<Widget> get pages => [
    const DashboardPage(),
    const RequestsPage(),
    ExamInformationPage(examInfoService: _examInfoService),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),

      appBar: AppBar(
        backgroundColor: UMTheme.maroon,
        foregroundColor: Colors.white,
        title: const Text(
          'ExamFlow Admin',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: pages[_currentIndex],

      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 65,
        backgroundColor: const Color(0xFFF5F6F8),
        color: UMTheme.maroon,
        buttonBackgroundColor: UMTheme.maroon,
        animationDuration: const Duration(milliseconds: 300),

        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.dashboard_outlined, color: Colors.white),
            label: 'Home',
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          CurvedNavigationBarItem(
            child: Icon(Icons.description_outlined, color: Colors.white),
            label: 'Requests',
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          CurvedNavigationBarItem(
            child: Icon(Icons.settings_outlined, color: Colors.white),
            label: 'Exam Info',
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          CurvedNavigationBarItem(
            child: Icon(Icons.person_outline, color: Colors.white),
            label: 'Profile',
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
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
}
