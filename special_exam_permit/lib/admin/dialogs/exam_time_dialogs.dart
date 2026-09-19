import 'package:flutter/material.dart';

import 'package:special_exam_permit/screens/special_exam_landing/um_theme.dart';
import 'package:special_exam_permit/service/exam_info_service.dart';

import '../helpers/date_helper.dart';
import '../helpers/time_helper.dart';
import 'delete_confirmation_dialog.dart';

class ExamTimeDialogs {
  static void showAdd(BuildContext context, CrudExamInfoService service) {
    DateTime? selectedDate;
    TimeOfDay? startTime;
    TimeOfDay? endTime;

    showDialog(
      context: context,
      builder: (dialogContext) {
        bool isLoading = false;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add Exam Schedule'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.calendar_today_outlined,
                        color: UMTheme.maroon,
                      ),
                      title: Text(
                        selectedDate == null
                            ? 'Select exam date'
                            : DateHelper.format(selectedDate!),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: isLoading
                          ? null
                          : () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: selectedDate ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );

                              if (date != null) {
                                setDialogState(() {
                                  selectedDate = date;
                                });
                              }
                            },
                    ),
                    const Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.access_time_outlined,
                        color: UMTheme.maroon,
                      ),
                      title: Text(
                        startTime == null
                            ? 'Select start time'
                            : startTime!.format(context),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: isLoading
                          ? null
                          : () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: startTime ?? TimeOfDay.now(),
                              );

                              if (time != null) {
                                setDialogState(() {
                                  startTime = time;
                                });
                              }
                            },
                    ),
                    const Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.access_time_filled_outlined,
                        color: UMTheme.maroon,
                      ),
                      title: Text(
                        endTime == null
                            ? 'Select end time'
                            : endTime!.format(context),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: isLoading
                          ? null
                          : () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: endTime ?? TimeOfDay.now(),
                              );

                              if (time != null) {
                                setDialogState(() {
                                  endTime = time;
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
                      : () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (selectedDate == null ||
                              startTime == null ||
                              endTime == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the date, start time, and end time.',
                                ),
                              ),
                            );
                            return;
                          }

                          setDialogState(() {
                            isLoading = true;
                          });

                          try {
                            await service.addExamTime(
                              examDate: selectedDate!,
                              startTime: startTime!.format(context),
                              endTime: endTime!.format(context),
                            );

                            if (context.mounted) {
                              Navigator.pop(dialogContext);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Exam schedule added successfully.',
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            setDialogState(() {
                              isLoading = false;
                            });

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Failed to add exam schedule: $e',
                                  ),
                                ),
                              );
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UMTheme.maroon,
                    foregroundColor: Colors.white,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static void showEdit(
    BuildContext context,
    CrudExamInfoService service,
    String id,
    DateTime? currentDate,
    String currentStartTime,
    String currentEndTime,
  ) {
    DateTime? selectedDate = currentDate;
    TimeOfDay? startTime = TimeHelper.parse(currentStartTime);
    TimeOfDay? endTime = TimeHelper.parse(currentEndTime);

    showDialog(
      context: context,
      builder: (dialogContext) {
        bool isLoading = false;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Exam Schedule'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.calendar_today_outlined,
                        color: UMTheme.maroon,
                      ),
                      title: Text(
                        selectedDate == null
                            ? 'Select exam date'
                            : DateHelper.format(selectedDate!),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: isLoading
                          ? null
                          : () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: selectedDate ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );

                              if (date != null) {
                                setDialogState(() {
                                  selectedDate = date;
                                });
                              }
                            },
                    ),
                    const Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.access_time_outlined,
                        color: UMTheme.maroon,
                      ),
                      title: Text(
                        startTime == null
                            ? 'Select start time'
                            : startTime!.format(context),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: isLoading
                          ? null
                          : () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: startTime ?? TimeOfDay.now(),
                              );

                              if (time != null) {
                                setDialogState(() {
                                  startTime = time;
                                });
                              }
                            },
                    ),
                    const Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.access_time_filled_outlined,
                        color: UMTheme.maroon,
                      ),
                      title: Text(
                        endTime == null
                            ? 'Select end time'
                            : endTime!.format(context),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: isLoading
                          ? null
                          : () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: endTime ?? TimeOfDay.now(),
                              );

                              if (time != null) {
                                setDialogState(() {
                                  endTime = time;
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
                      : () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (selectedDate == null ||
                              startTime == null ||
                              endTime == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the date, start time, and end time.',
                                ),
                              ),
                            );
                            return;
                          }

                          setDialogState(() {
                            isLoading = true;
                          });

                          try {
                            await service.updateExamTime(
                              id: id,
                              examDate: selectedDate!,
                              startTime: startTime!.format(context),
                              endTime: endTime!.format(context),
                            );

                            if (context.mounted) {
                              Navigator.pop(dialogContext);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Exam schedule updated successfully.',
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            setDialogState(() {
                              isLoading = false;
                            });

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Failed to update exam schedule: $e',
                                  ),
                                ),
                              );
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UMTheme.maroon,
                    foregroundColor: Colors.white,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static Future<void> delete(
    BuildContext context,
    CrudExamInfoService service,
    String id,
    String schedule,
  ) async {
    final confirmed = await DeleteConfirmationDialog.show(
      context,
      'Delete Exam Schedule',
      'Are you sure you want to delete "$schedule"?',
    );

    if (!confirmed) return;

    try {
      await service.deleteExamTime(id);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Exam schedule deleted successfully.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete exam schedule: $e')),
        );
      }
    }
  }
}
