-- Drops existing tables, so we start fresh with each
-- run of this script
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS teachers;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS sections;
DROP TABLE IF EXISTS enrollments;

CREATE TABLE students (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  first_name TEXT,
  last_name TEXT,
  email TEXT,
  phone_number TEXT
);

-- Create the rest of the tables

CREATE TABLE teachers (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  first_name TEXT,
  last_name TEXT,
  email TEXT
);

CREATE TABLE courses (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  course_name TEXT,
  course_code TEXT
);

CREATE TABLE sections (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  course_id INTEGER,
  teacher_id INTEGER,
  section_number TEXT,
  FOREIGN KEY (course_id) REFERENCES courses(id),
  FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

CREATE TABLE enrollments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  student_id INTEGER,
  section_id INTEGER,
  grade TEXT,
  FOREIGN KEY (student_id) REFERENCES students(id),
  FOREIGN KEY (section_id) REFERENCES sections(id)
);

-- Insert teachers
INSERT INTO teachers (first_name, last_name, email)
VALUES 
  ('Sarah', 'Johnson', 'sjohnson@school.edu'),
  ('Michael', 'Chen', 'mchen@school.edu'),
  ('Emma', 'Rodriguez', 'erodriguez@school.edu'),
  ('David', 'Park', 'dpark@school.edu');

-- Insert courses
INSERT INTO courses (course_name, course_code)
VALUES 
  ('Introduction to Computer Science', 'CS101'),
  ('Data Structures', 'CS201'),
  ('Database Systems', 'CS301'),
  ('Calculus I', 'MATH101'),
  ('Statistics', 'MATH210');

-- Insert students
INSERT INTO students (first_name, last_name, email, phone_number)
VALUES 
  ('Drew', 'Viscomi', 'dviscomi@school.edu', '555-0101'),
  ('Alex', 'Martinez', 'amartinez@school.edu', '555-0102'),
  ('Jordan', 'Lee', 'jlee@school.edu', '555-0103'),
  ('Taylor', 'Brown', 'tbrown@school.edu', '555-0104'),
  ('Morgan', 'Davis', 'mdavis@school.edu', '555-0105');

-- Insert sections (linking courses to teachers)
INSERT INTO sections (course_id, teacher_id, section_number)
VALUES 
  (1, 1, 'Fall-A'),  -- CS101 with Sarah Johnson
  (1, 1, 'Fall-B'),  -- CS101 with Sarah Johnson
  (2, 2, 'Fall-A'),  -- CS201 with Michael Chen
  (3, 2, 'Spring-A'), -- CS301 with Michael Chen
  (4, 3, 'Fall-A'),  -- MATH101 with Emma Rodriguez
  (5, 4, 'Spring-A'); -- MATH210 with David Park

-- Insert enrollments (registering students in sections)
INSERT INTO enrollments (student_id, section_id, grade)
VALUES 
  (1, 1, 'A'),   -- Drew in CS101 Fall-A
  (1, 5, 'A-'),  -- Drew in MATH101
  (2, 1, 'B+'),  -- Alex in CS101 Fall-A
  (2, 3, 'A'),   -- Alex in CS201
  (3, 2, 'A-'),  -- Jordan in CS101 Fall-B
  (3, 5, 'B'),   -- Jordan in MATH101
  (4, 3, 'B+'),  -- Taylor in CS201
  (4, 6, 'A'),   -- Taylor in MATH210
  (5, 1, 'A'),   -- Morgan in CS101 Fall-A
  (5, 4, NULL);  -- Morgan in CS301 (no grade yet)

  -- See which students are in which courses
SELECT students.first_name, students.last_name, courses.course_name
FROM enrollments
JOIN students ON enrollments.student_id = students.id
JOIN sections ON enrollments.section_id = sections.id
JOIN courses ON sections.course_id = courses.id;

-- See Drew's schedule
SELECT courses.course_code, courses.course_name, enrollments.grade
FROM enrollments
JOIN students ON enrollments.student_id = students.id
JOIN sections ON enrollments.section_id = sections.id
JOIN courses ON sections.course_id = courses.id
WHERE students.first_name = 'Drew' AND students.last_name = 'Viscomi';

-- See which teacher teaches which courses
SELECT teachers.first_name, teachers.last_name, courses.course_name, sections.section_number
FROM sections
JOIN teachers ON sections.teacher_id = teachers.id
JOIN courses ON sections.course_id = courses.id;

-- Count students per section
SELECT courses.course_name, sections.section_number, COUNT(enrollments.id) as student_count
FROM sections
JOIN courses ON sections.course_id = courses.id
LEFT JOIN enrollments ON sections.id = enrollments.section_id
GROUP BY sections.id;
