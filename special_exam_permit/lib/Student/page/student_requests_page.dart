import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:special_exam_permit/model/user_model.dart';
import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';

class StudentRequestsPage extends StatefulWidget {
  final UserModel user;

  const StudentRequestsPage({super.key, required this.user});

  @override
  State<StudentRequestsPage> createState() => _StudentRequestsPageState();
}

class _StudentRequestsPageState extends State<StudentRequestsPage> {
  final TextEditingController _searchController = TextEditingController();

  final ValueNotifier<String> _searchQuery = ValueNotifier<String>('');

  @override
  void dispose() {
    _searchController.dispose();
    _searchQuery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('exams_students_resquest')
            .where('studentId', isEqualTo: widget.user.studentId)
            .snapshots(),

        builder: (context, snapshot) {
          // ============================================================
          // LOADING
          // ============================================================

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: UMTheme.maroon),
            );
          }

          // ============================================================
          // ERROR
          // ============================================================

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load requests.\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          // ============================================================
          // ALL REQUESTS FROM FIRESTORE
          // ============================================================

          final allRequests = snapshot.data?.docs ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // ========================================================
                // PAGE TITLE
                // ========================================================
                const Text(
                  'My Requests',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: UMTheme.maroon,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'View your submitted special examination requests.',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),

                const SizedBox(height: 20),

                // ========================================================
                // SEARCH BAR
                // ========================================================
                TextField(
                  controller: _searchController,

                  // SEARCH CONTINUOUSLY WHILE TYPING
                  onChanged: (value) {
                    _searchQuery.value = value;
                  },

                  decoration: InputDecoration(
                    hintText: 'Search requests...',

                    // SEARCH ICON
                    prefixIcon: const Icon(Icons.search, color: UMTheme.maroon),

                    // CLEAR BUTTON
                    suffixIcon: ValueListenableBuilder<String>(
                      valueListenable: _searchQuery,
                      builder: (context, value, child) {
                        if (value.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _searchQuery.value = '';
                          },
                        );
                      },
                    ),

                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),

                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: UMTheme.maroon, width: 1.5),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // ========================================================
                // SEARCH RESULTS
                // ========================================================
                ValueListenableBuilder<String>(
                  valueListenable: _searchQuery,
                  builder: (context, searchQuery, child) {
                    final query = searchQuery.trim().toLowerCase();

                    // ======================================================
                    // FILTER REQUESTS
                    // ======================================================

                    final requests = allRequests.where((doc) {
                      // IF SEARCH IS EMPTY
                      if (query.isEmpty) {
                        return true;
                      }

                      final data = doc.data() as Map<String, dynamic>;

                      final subject =
                          data['subject']?.toString().toLowerCase() ?? '';

                      final reason =
                          data['reason']?.toString().toLowerCase() ?? '';

                      final examTime =
                          data['examTime']?.toString().toLowerCase() ?? '';

                      final status =
                          data['status']?.toString().toLowerCase() ?? '';

                      return subject.contains(query) ||
                          reason.contains(query) ||
                          examTime.contains(query) ||
                          status.contains(query);
                    }).toList();

                    // ======================================================
                    // NO REQUESTS AT ALL
                    // ======================================================

                    if (allRequests.isEmpty) {
                      return _buildEmptyState();
                    }

                    // ======================================================
                    // REQUESTS EXIST BUT SEARCH HAS NO RESULT
                    // ======================================================

                    if (requests.isEmpty) {
                      return _buildNoSearchResults();
                    }

                    // ======================================================
                    // DISPLAY FILTERED REQUESTS
                    // ======================================================

                    return Column(
                      children: requests
                          .map((doc) => _buildRequestCard(doc))
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(
            Icons.description_outlined,
            size: 55,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 15),

          const Text(
            'No Requests Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: UMTheme.maroon,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Your submitted requests will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NO SEARCH RESULTS
  // ============================================================

  Widget _buildNoSearchResults() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 55, color: Colors.grey.shade400),

          const SizedBox(height: 15),

          const Text(
            'No Matching Requests',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: UMTheme.maroon,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'No request matches your search.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // REQUEST CARD
  // ============================================================

  Widget _buildRequestCard(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    final subject = data['subject'] ?? '';
    final reason = data['reason'] ?? '';
    final examTime = data['examTime'] ?? '';
    final status = data['status'] ?? 'pending';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================================
          // SUBJECT + STATUS
          // ==========================================================

          Row(
            children: [
              const Icon(
                Icons.description_outlined,
                color: UMTheme.maroon,
                size: 28,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  subject,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: UMTheme.maroon,
                  ),
                ),
              ),

              _buildStatus(status),
            ],
          ),

          const SizedBox(height: 15),

          // ==========================================================
          // REASON
          // ==========================================================
          _buildInfoRow(Icons.info_outline, 'Reason', reason),

          const SizedBox(height: 8),

          // ==========================================================
          // EXAM TIME
          // ==========================================================
          _buildInfoRow(Icons.access_time, 'Exam Time', examTime),

          const SizedBox(height: 8),

          // ==========================================================
          // STUDENT
          // ==========================================================
          _buildInfoRow(
            Icons.person_outline,
            'Student',
            data['studentName'] ?? '',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // INFO ROW
  // ============================================================

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 19, color: Colors.grey.shade600),

        const SizedBox(width: 8),

        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // STATUS
  // ============================================================

  Widget _buildStatus(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _statusBackground(status),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: _statusColor(status),
        ),
      ),
    );
  }

  // ============================================================
  // STATUS COLOR
  // ============================================================

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green.shade700;

      case 'rejected':
        return Colors.red.shade700;

      case 'invalid':
        return Colors.orange.shade700;

      default:
        return UMTheme.maroon;
    }
  }

  // ============================================================
  // STATUS BACKGROUND
  // ============================================================

  Color _statusBackground(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green.shade50;

      case 'rejected':
        return Colors.red.shade50;

      case 'invalid':
        return Colors.orange.shade50;

      default:
        return Colors.grey.shade100;
    }
  }
}
