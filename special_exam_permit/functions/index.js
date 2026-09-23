const { onDocumentUpdated } = require("firebase-functions/v2/firestore");
const { defineSecret } = require("firebase-functions/params");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");

admin.initializeApp();

const gmailUser = process.env.GMAIL_USER;
const gmailAppPassword = process.env.GMAIL_APP_PASSWORD;

function createTransporter() {
  return nodemailer.createTransport({
    service: "gmail",
    auth: {
      user: gmailUser,
      pass: gmailAppPassword,
    },
  });
}

exports.sendExamRequestEmail = onDocumentUpdated(
  {
    document: "exams_students_resquest/{requestId}",
    region: "asia-southeast1",
  },
  async (event) => {
    const beforeData = event.data?.before.data();
    const afterData = event.data?.after.data();

    if (!beforeData || !afterData) {
      return;
    }

    const oldStatus = String(beforeData.status || "")
      .trim()
      .toLowerCase();

    const newStatus = String(afterData.status || "")
      .trim()
      .toLowerCase();

    // Only send when status actually changes
    if (oldStatus === newStatus) {
      return;
    }

    // Only send for approved/rejected
    if (newStatus !== "approved" && newStatus !== "rejected") {
      return;
    }

    const email = String(afterData.email || "")
      .trim()
      .toLowerCase();

    const studentName = String(afterData.studentName || "Student").trim();

    const subject = String(afterData.subject || "-").trim();

    const examTime = String(afterData.examTime || "-").trim();

    if (!email) {
      console.error("Student email is missing.");
      return;
    }

    const isApproved = newStatus === "approved";

    const html = `
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ExamFlow Notification</title>
</head>

<body style="
  margin:0;
  padding:20px;
  background:#f5f5f5;
  font-family:Arial,sans-serif;
">

  <div style="
    max-width:600px;
    margin:40px auto;
    background:white;
    border-radius:12px;
    padding:30px;
    box-shadow:0 2px 10px rgba(0,0,0,0.08);
  ">

    <h2 style="color:#800000;">
      ExamFlow
    </h2>

    <p>
      Hello <strong>${studentName}</strong>,
    </p>

    ${
      isApproved
        ? `
          <p>
            Your special examination request has been
            <strong style="color:green;">
              approved
            </strong>.
          </p>
        `
        : `
          <p>
            Your special examination request has been
            <strong style="color:#c62828;">
              rejected
            </strong>.
          </p>
        `
    }

    <div style="
      background:#f8f8f8;
      padding:18px;
      border-radius:8px;
      margin:20px 0;
    ">

      <p>
        <strong>Subject:</strong> ${subject}
      </p>

      <p>
        <strong>Exam Time:</strong> ${examTime}
      </p>

      <p>
        <strong>Status:</strong>
        ${isApproved ? "Approved" : "Rejected"}
      </p>

    </div>

    ${
      isApproved
        ? `
          <p>
            Please check your ExamFlow account for the
            details of your approved special examination permit.
          </p>
        `
        : `
          <p>
            Please check your ExamFlow account for more
            details regarding your request.
          </p>
        `
    }

    <p>Thank you.</p>

    <hr style="
      border:none;
      border-top:1px solid #ddd;
      margin:25px 0;
    ">

    <p style="
      font-size:12px;
      color:#777;
    ">
      This is an automated email from ExamFlow.
      Please do not reply to this email.
    </p>

  </div>

</body>
</html>
`;

    try {
      const transporter = createTransporter();

      const info = await transporter.sendMail({
        from: `ExamFlow <${gmailUser}>`,
        to: email,
        subject: isApproved
          ? "Special Exam Request Approved"
          : "Special Exam Request Rejected",
        html,
      });

      console.log(`Exam request email sent to ${email}:`, info.messageId);
    } catch (error) {
      console.error("Exam request email error:", error);
    }
  },
);
