
USE campus_repository;

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE faculty_reviews;
TRUNCATE TABLE project_attachments;
TRUNCATE TABLE project_tags;
TRUNCATE TABLE project_authors;
TRUNCATE TABLE projects;
TRUNCATE TABLE tags;
TRUNCATE TABLE users;
TRUNCATE TABLE departments;

SET FOREIGN_KEY_CHECKS = 1;


INSERT INTO departments (department_id, dept_code, dept_name) VALUES
(1, 'CS', 'Computer Science & Engineering'),
(2, 'IT', 'Information Technology'),
(3, 'ECE', 'Electronics & Communication Engineering'),
(4, 'MECH', 'Mechatronics Engineering'),
(5, 'MBA', 'Master of Business Administration');


INSERT INTO tags (tag_id, tag_name) VALUES
(1, 'Python'),
(2, 'React'),
(3, 'Node.js'),
(4, 'Machine Learning'),
(5, 'MySQL'),
(6, 'Flutter'),
(7, 'Docker'),
(8, 'TensorFlow'),
(9, 'AWS'),
(10, 'Java'),
(11, 'Spring Boot'),
(12, 'Blockchain'),
(13, 'OpenCV'),
(14, 'Cyber Security'),
(15, 'IoT');


INSERT INTO users (user_id, full_name, email, password_hash, role, department_id, roll_or_emp_id, is_active) VALUES
(1, 'Aarav Sharma', 'aarav.sharma@student.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'STUDENT', 1, '2023CS101', TRUE),
(2, 'Ananya Verma', 'ananya.verma@student.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'STUDENT', 1, '2023CS102', TRUE),
(3, 'Rohan Mehta', 'rohan.mehta@student.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'STUDENT', 2, '2023IT101', TRUE),
(4, 'Priya Patel', 'priya.patel@student.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'STUDENT', 2, '2023IT102', TRUE),
(5, 'Vikram Singh', 'vikram.singh@student.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'STUDENT', 3, '2023ECE101', TRUE),
(6, 'Sneha Rao', 'sneha.rao@student.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'STUDENT', 3, '2023ECE102', TRUE),
(7, 'Aditya Joshi', 'aditya.joshi@student.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'STUDENT', 4, '2023MECH101', TRUE),
(8, 'Kavya Nair', 'kavya.nair@student.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'STUDENT', 4, '2023MECH102', TRUE),
(9, 'Siddharth Gupta', 'siddharth.gupta@student.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'STUDENT', 5, '2023MBA101', TRUE),
(10, 'Diya Iyer', 'diya.iyer@student.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'STUDENT', 5, '2023MBA102', TRUE);

INSERT INTO users (user_id, full_name, email, password_hash, role, department_id, roll_or_emp_id, is_active) VALUES
(11, 'Dr. Rajesh Kumar', 'rajesh.kumar@faculty.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'FACULTY', 1, 'EMP_CS_01', TRUE),
(12, 'Prof. Sunita Deshmukh', 'sunita.deshmukh@faculty.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'FACULTY', 1, 'EMP_CS_02', TRUE),
(13, 'Dr. Amitav Sanyal', 'amitav.sanyal@faculty.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'FACULTY', 2, 'EMP_IT_01', TRUE),
(14, 'Prof. Meenakshi Sundaram', 'meenakshi.s@faculty.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'FACULTY', 3, 'EMP_ECE_01', TRUE),
(15, 'Dr. Suresh Reddy', 'suresh.reddy@faculty.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'FACULTY', 4, 'EMP_MECH_01', TRUE),
(16, 'Prof. Shalini Roy', 'shalini.roy@faculty.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'FACULTY', 5, 'EMP_MBA_01', TRUE),
(17, 'Dr. Anand Kulkarni', 'anand.kulkarni@faculty.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'FACULTY', 2, 'EMP_IT_02', TRUE);

INSERT INTO users (user_id, full_name, email, password_hash, role, department_id, roll_or_emp_id, is_active) VALUES
(18, 'System Administrator', 'admin.main@college.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'ADMIN', 1, 'EMP_ADM_01', TRUE),
(19, 'Dean Academic Affairs', 'dean.academics@college.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'ADMIN', 1, 'EMP_ADM_02', TRUE),
(20, 'IT Head Administrator', 'it.head@college.edu', '$2b$10$e8N8xW7G5J2k4L6M8N1O2u3V4W5X6Y7Z8A9B0C1D2E3F4G5H6I7J8', 'ADMIN', 2, 'EMP_ADM_03', TRUE);

INSERT INTO projects (project_id, title, abstract, academic_year, department_id, lead_student_id, guide_id, status, views_count, downloads_count) VALUES
(1, 'AI-Based Automated Attendance System using Facial Recognition', 'This project proposes a real-time face recognition model using OpenCV and Deep Learning to automate student attendance marking in classrooms, reducing manual entry time by 95%.', 2025, 1, 1, 11, 'APPROVED', 245, 82),
(2, 'Decentralized Academic Credential Verification via Blockchain', 'A tamper-proof web platform leveraging Ethereum smart contracts to issue, verify, and store college transcripts and degree certificates securely.', 2025, 2, 3, 13, 'APPROVED', 189, 45),
(3, 'Smart IoT Agriculture Monitoring System with Crop Yield Prediction', 'An integrated hardware and cloud solution utilizing soil sensors and predictive machine learning algorithms to assist farmers in optimizing water and fertilizer usage.', 2026, 3, 5, 14, 'PENDING', 34, 3),
(4, 'Autonomous Robotic Arm for Warehouse Sorting', 'A mechatronics system incorporating machine vision and inverse kinematics to sort packages autonomously in industrial distribution centers.', 2026, 4, 7, 15, 'PENDING', 12, 0),
(5, 'Consumer Behavior Analysis in Post-Pandemic E-Commerce Platforms', 'A data-driven study exploring shifting purchasing patterns, customer retention metrics, and digital marketing efficiency across retail brands.', 2026, 5, 9, 16, 'PENDING', 8, 1),
(6, 'Cross-Platform Mobile Application for Campus Asset Tracking', 'A Flutter-based mobile application integrated with Firebase to track college library books, lab equipment, and sports gear in real-time.', 2026, 2, 4, 17, 'NEEDS_REVISION', 78, 11),
(7, 'Autonomous Obstacle-Avoiding Drone for Search and Rescue', 'A quadcopter design using LIDAR sensors and ROS (Robot Operating System) to navigate hazardous GPS-denied indoor environments.', 2026, 4, 8, 15, 'NEEDS_REVISION', 92, 14),
(8, 'Basic E-Commerce Shopping Cart System', 'A standard web application built using HTML, CSS, and basic PHP to demonstrate online shopping cart operations without modern security standards.', 2025, 1, 2, 12, 'REJECTED', 41, 2);

INSERT INTO project_authors (project_id, student_id) VALUES
(1, 1), (1, 2),
(2, 3),
(3, 5), (3, 6),
(4, 7),
(5, 9),
(6, 4),
(7, 8), (7, 7),
(8, 2);

INSERT INTO project_tags (project_id, tag_id) VALUES
(1, 1), (1, 4), (1, 13),
(2, 12), (2, 3), (2, 2),
(3, 15), (3, 1), (3, 4),
(4, 1), (4, 13), (4, 15),
(5, 1), (5, 5),
(6, 6), (6, 5), (6, 7),
(7, 1), (7, 13), (7, 15),
(8, 5);

INSERT INTO project_attachments (project_id, file_type, original_name, stored_file_path, file_size_bytes, file_hash) VALUES
(1, 'REPORT_PDF', 'AI_Attendance_Final_Report.pdf', 'uploads/2025/cs/p1_report.pdf', 4521980, 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
(1, 'SOURCE_ZIP', 'AI_Attendance_SourceCode.zip', 'uploads/2025/cs/p1_source.zip', 18450200, 'f412c34298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b901'),
(2, 'REPORT_PDF', 'Blockchain_Verification_Doc.pdf', 'uploads/2025/it/p2_report.pdf', 3210450, 'a1b2c34298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b111'),
(3, 'REPORT_PDF', 'Smart_Agri_Synopsis.pdf', 'uploads/2026/ece/p3_synopsis.pdf', 1890200, 'c3d4e54298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b222'),
(6, 'REPORT_PDF', 'Asset_Tracking_V1_Report.pdf', 'uploads/2026/it/p6_report.pdf', 2980100, 'd5e6f74298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b333'),
(7, 'REPORT_PDF', 'Rescue_Drone_Initial_Draft.pdf', 'uploads/2026/mech/p7_draft.pdf', 5120000, 'e7f8a94298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b444'),
(8, 'REPORT_PDF', 'Ecommerce_Cart_Documentation.pdf', 'uploads/2025/cs/p8_report.pdf', 1200400, 'f9a0b14298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b555');

INSERT INTO faculty_reviews (project_id, faculty_id, decision, comments, reviewed_at) VALUES
(1, 11, 'APPROVED', 'Excellent research work. Abstract and system architecture are thoroughly detailed. Approved for repository archiving.', '2025-04-15 10:30:00'),
(2, 13, 'APPROVED', 'Smart contract deployment verified successfully on testnet. Great practical application of blockchain.', '2025-05-10 14:15:00'),
(6, 17, 'REVISION_REQUESTED', 'Please add data encryption standards for user authentication before approval.', '2026-02-01 11:00:00'),
(7, 15, 'REVISION_REQUESTED', 'Sensor calibration logs are missing from the project report. Resubmit with indoor flight telemetry data.', '2026-02-10 16:45:00'),
(8, 12, 'REJECTED', 'Project scope is too basic for a final year capstone. Lacks security protocols, authentication standards, and modern architecture.', '2025-04-20 09:20:00');


/*my code*/
SELECT * FROM users;
SELECT * FROM projects;
SELECT * FROM departments;
SELECT * FROM tags;
SELECT * FROM project_tags;
SELECT * FROM project_authors;
SELECT * FROM project_attachments;
SELECT * FROM faculty_reviews;
