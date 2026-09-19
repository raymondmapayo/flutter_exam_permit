import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:special_exam_permit/main_request_form.dart';
import 'package:special_exam_permit/model/exam_reason_model.dart';
import 'package:special_exam_permit/model/exam_subject_model.dart';
import 'package:special_exam_permit/model/exam_time_model.dart';
import 'package:special_exam_permit/service/crud_exam_info_service.dart';

import 'package:special_exam_permit/service/uplaod_service.dart';

class ExamRequestPage extends StatefulWidget {
  const ExamRequestPage({super.key});

  @override
  State<ExamRequestPage> createState() => _ExamRequestPageState();
}

class _ExamRequestPageState extends State<ExamRequestPage> {
  @override
  void dispose() {
    _studentIdController.dispose();
    _studentNameController.dispose();
    _courseYearController.dispose();
    _emailController.dispose();
    _additionalDetailsController.dispose();

    super.dispose();
  }
  // ============================================================
  // FIREBASE SERVICE
  // ============================================================

  final CrudExamInfoService _examInfoService = CrudExamInfoService();
  final UploadFileService _uploadFileService = UploadFileService();
  // TEXT FIELD CONTROLLERS
  final TextEditingController _studentIdController = TextEditingController();

  final TextEditingController _studentNameController = TextEditingController();

  final TextEditingController _courseYearController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _additionalDetailsController =
      TextEditingController();
  // ============================================================
  // FIREBASE DATA
  // ============================================================

  List<ExamSubjectModel> subjects = [];
  List<ExamReasonModel> reasons = [];
  List<ExamTimeModel> examTimes = [];

  // ============================================================
  // DROPDOWN VALUES
  // ============================================================

  String? selectedSubject;
  String? selectedReason;
  String? selectedExamTime;

  // ============================================================
  // TEXTFIELD VALUES
  // ============================================================

  PlatformFile? selectedFile;
  String? uploadedDocumentUrl;

  bool isUploading = false;
  bool isSubmitting = false;
  // ============================================================
  // ERROR MESSAGES
  // ============================================================

  String? studentIdError;
  String? studentNameError;
  String? courseYearError;
  String? emailError;
  String? subjectError;
  String? reasonError;
  String? additionalDetailsError;
  String? examTimeError;

  // ============================================================
  // LOAD FIREBASE DATA
  // ============================================================

  @override
  void initState() {
    super.initState();

    _loadSubjects();
    _loadReasons();
    _loadExamTimes();
  }

  // ============================================================
  // LOAD SUBJECTS
  // ============================================================

  void _loadSubjects() {
    _examInfoService.getSubjects().listen((snapshot) {
      if (!mounted) return;

      setState(() {
        subjects = snapshot.docs.map((doc) {
          return ExamSubjectModel.fromFirestore(
            doc.id,
            doc.data() as Map<String, dynamic>,
          );
        }).toList();
      });
    });
  }

  // ============================================================
  // LOAD REASONS
  // ============================================================

  void _loadReasons() {
    _examInfoService.getReasons().listen((snapshot) {
      if (!mounted) return;

      setState(() {
        reasons = snapshot.docs.map((doc) {
          return ExamReasonModel.fromFirestore(
            doc.id,
            doc.data() as Map<String, dynamic>,
          );
        }).toList();
      });
    });
  }

  // ============================================================
  // CHOOSE AND UPLOAD DOCUMENT
  // ============================================================

  Future<void> _chooseFile() async {
    final PlatformFile? file = await FilePicker.pickFile(type: FileType.image);

    if (file == null || !mounted) {
      return;
    }

    setState(() {
      selectedFile = file;
      uploadedDocumentUrl = null;
      isUploading = true;
    });

    try {
      final String url = await _uploadFileService.uploadFile(file);

      if (!mounted) return;

      setState(() {
        uploadedDocumentUrl = url;
        isUploading = false;
      });

      debugPrint('FILE NAME: ${file.name}');
      debugPrint('FILE PATH: ${file.path}');
      debugPrint('CLOUDINARY URL: $url');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Document uploaded successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        selectedFile = null;
        uploadedDocumentUrl = null;
        isUploading = false;
      });

      debugPrint('UPLOAD ERROR: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Upload failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  // ============================================================
  // LOAD EXAM TIMES
  // ============================================================

  void _loadExamTimes() {
    _examInfoService.getExamTimes().listen((snapshot) {
      if (!mounted) return;

      setState(() {
        examTimes = snapshot.docs.map((doc) {
          return ExamTimeModel.fromFirestore(
            doc.id,
            doc.data() as Map<String, dynamic>,
          );
        }).toList();
      });
    });
  }

  void _clearForm() {
    // CLEAR TEXT FIELDS
    _studentIdController.clear();
    _studentNameController.clear();
    _courseYearController.clear();
    _emailController.clear();
    _additionalDetailsController.clear();

    // CLEAR DROPDOWNS, FILE, ERRORS
    setState(() {
      selectedSubject = null;
      selectedReason = null;
      selectedExamTime = null;

      selectedFile = null;
      uploadedDocumentUrl = null;

      isUploading = false;
      isSubmitting = false;

      studentIdError = null;
      studentNameError = null;
      courseYearError = null;
      emailError = null;
      subjectError = null;
      reasonError = null;
      additionalDetailsError = null;
      examTimeError = null;
    });
  }

  // ============================================================
  // SUBMIT REQUEST
  // ============================================================

  Future<void> _submitRequest() async {
    setState(() {
      // STUDENT ID
      studentIdError = _studentIdController.text.trim().isEmpty
          ? 'Student ID is required'
          : null;

      // STUDENT NAME
      studentNameError = _studentNameController.text.trim().isEmpty
          ? 'Student Name is required'
          : null;

      // COURSE & YEAR
      courseYearError = _courseYearController.text.trim().isEmpty
          ? 'Course & Year is required'
          : null;

      // EMAIL
      emailError = _emailController.text.trim().isEmpty
          ? 'Email is required'
          : null;

      // SUBJECT
      subjectError = selectedSubject == null ? 'Please select a subject' : null;

      // REASON
      reasonError = selectedReason == null ? 'Please select a reason' : null;

      // ADDITIONAL DETAILS
      additionalDetailsError = _additionalDetailsController.text.trim().isEmpty
          ? 'Additional details are required'
          : null;

      // EXAM TIME
      examTimeError = selectedExamTime == null
          ? 'Please select an exam time'
          : null;
    });

    // ============================================================
    // CHECK FORM ERRORS
    // ============================================================

    final hasError =
        studentIdError != null ||
        studentNameError != null ||
        courseYearError != null ||
        emailError != null ||
        subjectError != null ||
        reasonError != null ||
        additionalDetailsError != null ||
        examTimeError != null;

    // STOP IF THERE IS AN ERROR
    if (hasError) {
      return;
    }

    // ============================================================
    // CHECK DOCUMENT
    // ============================================================

    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload a supporting document.'),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    // ============================================================
    // CHECK IF DOCUMENT IS STILL UPLOADING
    // ============================================================

    if (isUploading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please wait for the document to finish uploading.'),
          backgroundColor: Colors.orange,
        ),
      );

      return;
    }

    // ============================================================
    // CHECK CLOUDINARY URL
    // ============================================================

    if (uploadedDocumentUrl == null || uploadedDocumentUrl!.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Document upload failed. Please upload again.'),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    // ============================================================
    // SUBMIT TO FIRESTORE
    // ============================================================

    try {
      setState(() {
        isSubmitting = true;
      });

      await _examInfoService.addExamRequest(
        studentId: _studentIdController.text.trim(),
        studentName: _studentNameController.text.trim(),
        courseYear: _courseYearController.text.trim(),
        email: _emailController.text.trim(),
        subject: selectedSubject!,
        reason: selectedReason!,
        examTime: selectedExamTime!,
        additionalDetails: _additionalDetailsController.text.trim(),
        documentUrl: uploadedDocumentUrl!,
      );

      if (!mounted) return;

      // CLEAR FORM AFTER SUCCESS
      _clearForm();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Request submitted successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isSubmitting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit request: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return MainRequestForm(
      // ============================================================
      // FIREBASE DATA
      // ============================================================

      subjects: subjects,
      reasons: reasons,
      examTimes: examTimes,

      studentIdController: _studentIdController,
      studentNameController: _studentNameController,
      courseYearController: _courseYearController,
      emailController: _emailController,
      additionalDetailsController: _additionalDetailsController,
      // ============================================================
      // DROPDOWN VALUES
      // ============================================================
      selectedSubject: selectedSubject,
      selectedReason: selectedReason,
      selectedExamTime: selectedExamTime,

      // ============================================================
      // ERROR MESSAGES
      // ============================================================
      studentIdError: studentIdError,
      studentNameError: studentNameError,
      courseYearError: courseYearError,
      emailError: emailError,
      subjectError: subjectError,
      reasonError: reasonError,
      additionalDetailsError: additionalDetailsError,
      examTimeError: examTimeError,

      // ============================================================
      // DOCUMENT UPLOAD
      // ============================================================
      selectedFileName: selectedFile?.name,
      onChooseFile: _chooseFile,
      isUploading: isUploading,
      isSubmitting: isSubmitting,

      // ============================================================
      // SUBJECT
      // ============================================================
      onSubjectChanged: (value) {
        setState(() {
          selectedSubject = value;
          subjectError = null;
        });
      },

      // ============================================================
      // REASON
      // ============================================================
      onReasonChanged: (value) {
        setState(() {
          selectedReason = value;
          reasonError = null;
        });
      },

      // ============================================================
      // EXAM TIME
      // ============================================================
      onExamTimeChanged: (value) {
        setState(() {
          selectedExamTime = value;
          examTimeError = null;
        });
      },

      // ============================================================
      // STUDENT ID
      // ============================================================
      onStudentIdChanged: (value) {
        setState(() {
          if (value.trim().isNotEmpty) {
            studentIdError = null;
          }
        });
      },
      // ============================================================
      // STUDENT NAME
      // ============================================================
      onStudentNameChanged: (value) {
        setState(() {
          if (value.trim().isNotEmpty) {
            studentNameError = null;
          }
        });
      },

      // ============================================================
      // COURSE & YEAR
      // ============================================================
      onCourseYearChanged: (value) {
        setState(() {
          if (value.trim().isNotEmpty) {
            courseYearError = null;
          }
        });
      },
      // ============================================================
      // EMAIL
      // ============================================================
      onEmailChanged: (value) {
        setState(() {
          if (value.trim().isNotEmpty) {
            emailError = null;
          }
        });
      },
      // ============================================================
      // ADDITIONAL DETAILS
      // ============================================================
      onAdditionalDetailsChanged: (value) {
        setState(() {
          if (value.trim().isNotEmpty) {
            additionalDetailsError = null;
          }
        });
      },

      // ============================================================
      // SUBMIT
      // ============================================================
      onSubmit: _submitRequest,
    );
  }
}
