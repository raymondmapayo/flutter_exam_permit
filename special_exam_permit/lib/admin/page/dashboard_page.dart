import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';
import 'package:special_exam_permit/service/crud_exam_info_service.dart';

import '../widgets/stat_card.dart';
import '../dialogs/request_details_dialog.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

void _showFullImage(BuildContext context, String documentUrl) {
  showDialog(
    context: context,
    barrierColor: Colors.black87,
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: SizedBox(
          width: MediaQuery.of(dialogContext).size.width * 0.9,
          height: MediaQuery.of(dialogContext).size.height * 0.85,
          child: Stack(
            children: [
              Positioned.fill(
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 5,
                  child: Center(
                    child: Image.network(documentUrl, fit: BoxFit.contain),
                  ),
                ),
              ),

              Positioned(
                top: 8,
                right: 8,
                child: Material(
                  color: Colors.black54,
                  shape: const CircleBorder(),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _DashboardPageState extends State<DashboardPage> {
  final CrudExamInfoService _service = CrudExamInfoService();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: UMTheme.maroon,
            ),
          ),

          const SizedBox(height: 32),

          const Text(
            'Request Trends',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 14),

          Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 300,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _service.getExamRequests(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: UMTheme.maroon),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error loading request trends: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    final requests = snapshot.data?.docs ?? [];

                    return _buildLineChart(requests);
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Manage special examination requests.',
            style: TextStyle(color: Colors.grey.shade600),
          ),

          const SizedBox(height: 24),

          // =====================================================
          // STAT CARDS
          // =====================================================
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final cardWidth = width > 700 ? (width - 32) / 3 : width;

              return StreamBuilder<QuerySnapshot>(
                stream: _service.getExamRequests(),
                builder: (context, snapshot) {
                  // Loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        StatCard(
                          width: cardWidth,
                          title: 'Pending',
                          value: '...',
                          icon: Icons.pending_actions,
                        ),
                        StatCard(
                          width: cardWidth,
                          title: 'Approved',
                          value: '...',
                          icon: Icons.check_circle_outline,
                        ),
                        StatCard(
                          width: cardWidth,
                          title: 'Rejected',
                          value: '...',
                          icon: Icons.cancel_outlined,
                        ),
                      ],
                    );
                  }

                  // Error
                  if (snapshot.hasError) {
                    return const Text(
                      'Unable to load request statistics.',
                      style: TextStyle(color: Colors.red),
                    );
                  }

                  final requests = snapshot.data?.docs ?? [];

                  int pendingCount = 0;
                  int approvedCount = 0;
                  int rejectedCount = 0;

                  for (final doc in requests) {
                    final data = doc.data() as Map<String, dynamic>;

                    final status =
                        data['status']?.toString().toLowerCase() ?? 'pending';

                    if (status == 'pending') {
                      pendingCount++;
                    } else if (status == 'approved') {
                      approvedCount++;
                    } else if (status == 'rejected') {
                      rejectedCount++;
                    }
                  }

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      StatCard(
                        width: cardWidth,
                        title: 'Pending',
                        value: pendingCount.toString(),
                        icon: Icons.pending_actions,
                      ),

                      StatCard(
                        width: cardWidth,
                        title: 'Approved',
                        value: approvedCount.toString(),
                        icon: Icons.check_circle_outline,
                      ),

                      StatCard(
                        width: cardWidth,
                        title: 'Rejected',
                        value: rejectedCount.toString(),
                        icon: Icons.cancel_outlined,
                      ),
                    ],
                  );
                },
              );
            },
          ),

          const SizedBox(height: 24),

          // =====================================================
          // RECENT REQUESTS
          // =====================================================
          const Text(
            'Recent Requests',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 14),

          Card(
            elevation: 1,
            child: StreamBuilder<QuerySnapshot>(
              stream: _service.getExamRequests(),
              builder: (context, snapshot) {
                // Loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(
                      child: CircularProgressIndicator(color: UMTheme.maroon),
                    ),
                  );
                }

                // Error
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Error loading requests: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                // Empty
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(
                      child: Text(
                        'No exam requests found.',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  );
                }

                final requests = snapshot.data!.docs;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Student')),
                      DataColumn(label: Text('Subject')),
                      DataColumn(label: Text('Exam Time')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Action')),
                    ],

                    rows: requests.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;

                      final studentName =
                          data['studentName']?.toString() ?? 'Unknown';

                      final subject = data['subject']?.toString() ?? '-';

                      final examTime = data['examTime']?.toString() ?? '-';

                      final status = data['status']?.toString() ?? 'pending';

                      return DataRow(
                        cells: [
                          // Student
                          DataCell(Text(studentName)),

                          // Subject
                          DataCell(Text(subject)),

                          // Exam Time
                          DataCell(Text(examTime)),

                          // Status
                          DataCell(_buildStatusBadge(status)),

                          // Action
                          DataCell(
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert),

                              onSelected: (value) {
                                if (value == 'view') {
                                  _viewRequest(context, doc);
                                }

                                if (value == 'edit') {
                                  _editRequest(context, doc);
                                }

                                if (value == 'delete') {
                                  _deleteRequest(context, doc);
                                }
                              },

                              itemBuilder: (context) {
                                return const [
                                  PopupMenuItem(
                                    value: 'view',
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.visibility_outlined,
                                          size: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Text('View'),
                                      ],
                                    ),
                                  ),

                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit_outlined, size: 20),
                                        SizedBox(width: 10),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),

                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete_outline, size: 20),
                                        SizedBox(width: 10),
                                        Text('Delete'),
                                      ],
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STATUS BADGE
  // ============================================================

  Widget _buildStatusBadge(String status) {
    Color color;

    switch (status.toLowerCase()) {
      case 'approved':
        color = Colors.green;
        break;

      case 'rejected':
        color = Colors.red;
        break;

      default:
        color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ============================================================
  // VIEW REQUEST
  // ============================================================

  void _viewRequest(BuildContext context, QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    RequestDetailsDialog.show(
      context,
      data['studentName']?.toString() ?? '-',
      data['subject']?.toString() ?? '-',
      data['examTime']?.toString() ?? '-',
      data['status']?.toString() ?? 'pending',
    );
  }

  // ============================================================
  // EDIT REQUEST
  // ============================================================

  void _editRequest(BuildContext context, QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    String currentStatus =
        data['status']?.toString().trim().toLowerCase() ?? 'pending';

    // Make sure the value exists in the dropdown items.
    if (!['pending', 'approved', 'rejected'].contains(currentStatus)) {
      currentStatus = 'pending';
    }

    bool isLoading = false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Update Request Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Student: ${data['studentName'] ?? '-'}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),

                    Text(
                      'Subject: ${data['subject'] ?? '-'}',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),

                    const SizedBox(height: 16),

                    _buildDocumentPreview(data['documentUrl']?.toString()),

                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      initialValue: currentStatus,
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),

                      items: const [
                        DropdownMenuItem(
                          value: 'pending',
                          child: Text('Pending'),
                        ),
                        DropdownMenuItem(
                          value: 'approved',
                          child: Text('Approved'),
                        ),
                        DropdownMenuItem(
                          value: 'rejected',
                          child: Text('Rejected'),
                        ),
                      ],

                      onChanged: isLoading
                          ? null
                          : (value) {
                              if (value != null) {
                                setDialogState(() {
                                  currentStatus = value;
                                });
                              }
                            },
                    ),
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          Navigator.pop(dialogContext);
                        },
                  child: const Text('Cancel'),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UMTheme.maroon,
                    foregroundColor: Colors.white,
                  ),

                  onPressed: isLoading
                      ? null
                      : () async {
                          setDialogState(() {
                            isLoading = true;
                          });

                          try {
                            // =================================================
                            // UPDATE STATUS + SEND EMAIL
                            // =================================================
                            await _service.updateExamRequestStatus(
                              documentId: doc.id,
                              status: currentStatus,
                            );

                            if (!context.mounted) return;

                            Navigator.pop(dialogContext);

                            // =================================================
                            // SUCCESS MESSAGE
                            // =================================================
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  currentStatus == 'approved'
                                      ? 'Request approved. Email notification sent.'
                                      : currentStatus == 'rejected'
                                      ? 'Request rejected. Email notification sent.'
                                      : 'Request status updated successfully.',
                                ),
                              ),
                            );
                          } catch (e) {
                            if (!context.mounted) return;

                            setDialogState(() {
                              isLoading = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to update status: $e'),
                              ),
                            );
                          }
                        },

                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }
  // ============================================================
  // DELETE REQUEST
  // ============================================================

  Future<void> _deleteRequest(
    BuildContext context,
    QueryDocumentSnapshot doc,
  ) async {
    final data = doc.data() as Map<String, dynamic>;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Request'),
          content: Text(
            'Are you sure you want to delete the request '
            'from ${data['studentName'] ?? 'this student'}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    try {
      await _service.deleteExamRequest(doc.id);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request deleted successfully.')),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to delete request: $e')));
    }
  }

  // ============================================================
  // LINE CHART
  // ============================================================

  Widget _buildLineChart(List<QueryDocumentSnapshot> requests) {
    final monthlyCounts = List<int>.filled(12, 0);

    for (final doc in requests) {
      final data = doc.data() as Map<String, dynamic>;

      final createdAt = data['createdAt'];

      if (createdAt is Timestamp) {
        final date = createdAt.toDate();

        // Current year only
        if (date.year == DateTime.now().year) {
          monthlyCounts[date.month - 1]++;
        }
      }
    }

    final maxCount = monthlyCounts.reduce((a, b) => a > b ? a : b);

    final chartMaxY = maxCount < 5 ? 5.0 : ((maxCount + 4) ~/ 5 * 5).toDouble();

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: chartMaxY,

        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 5,
        ),

        borderData: FlBorderData(show: false),

        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),

          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),

          // LEFT NUMBERS
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              interval: 5,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(color: Colors.black87, fontSize: 12),
                );
              },
            ),
          ),

          // MONTHS
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: (value, meta) {
                const months = [
                  'Jan',
                  'Feb',
                  'Mar',
                  'Apr',
                  'May',
                  'Jun',
                  'Jul',
                  'Aug',
                  'Sep',
                  'Oct',
                  'Nov',
                  'Dec',
                ];

                final index = value.toInt();

                if (index < 0 || index >= months.length) {
                  return const SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    months[index],
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              12,
              (index) =>
                  FlSpot(index.toDouble(), monthlyCounts[index].toDouble()),
            ),

            isCurved: true,

            // UM MAROON
            color: UMTheme.maroon,
            barWidth: 3,

            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: UMTheme.maroon,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),

            // LIGHT MAROON AREA
            belowBarData: BarAreaData(
              show: true,
              color: UMTheme.maroon.withOpacity(0.08),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentPreview(String? documentUrl) {
    if (documentUrl == null || documentUrl.isEmpty) {
      return const Text(
        'No supporting document uploaded.',
        style: TextStyle(color: Colors.grey),
      );
    }

    bool isHovering = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Supporting Document',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10),

            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) {
                setState(() => isHovering = true);
              },
              onExit: (_) {
                setState(() => isHovering = false);
              },
              child: GestureDetector(
                onTap: () {
                  _showFullImage(context, documentUrl);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isHovering ? UMTheme.maroon : Colors.grey.shade300,
                      width: isHovering ? 2 : 1,
                    ),
                    boxShadow: isHovering
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          documentUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Text(
                                'Unable to load image',
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          },
                        ),

                        // Hover overlay
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: isHovering ? 1 : 0,
                          child: Container(
                            color: Colors.black54,
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.zoom_in,
                                    color: Colors.white,
                                    size: 38,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'View Full',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),

            Text(
              'Click the image to view full size',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        );
      },
    );
  }
}
