                                 **// Creating relationships between databases and performing Joins, Sub-queries //**

🕒PROGRAM :
            CREATE DATABASE IF NOT EXISTS CollegeDB;
            USE CollegeDB;

            -- Drop tables in dependency order so the script can be re-run
            DROP TABLE IF EXISTS Enrollment;
            DROP TABLE IF EXISTS Course;
            DROP TABLE IF EXISTS Student;
            DROP TABLE IF EXISTS Department;

            -- 1. Create related tables
            CREATE TABLE Department (
                dept_id INT PRIMARY KEY,
                dept_name VARCHAR(50) NOT NULL,
                location VARCHAR(50)
            );

            CREATE TABLE Student (
                student_id INT PRIMARY KEY,
                student_name VARCHAR(50) NOT NULL,
                dept_id INT,
                cgpa DECIMAL(3,2),
                CONSTRAINT fk_student_department
                    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
            );

            CREATE TABLE Course (
                course_id INT PRIMARY KEY,
                course_name VARCHAR(60) NOT NULL,
                dept_id INT,
                credits INT,
                CONSTRAINT fk_course_department
                    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
            );

            CREATE TABLE Enrollment (
                enroll_id INT PRIMARY KEY,
                student_id INT,
                course_id INT,
                semester INT,
                marks INT,
                CONSTRAINT fk_enrollment_student
                    FOREIGN KEY (student_id) REFERENCES Student(student_id),
                CONSTRAINT fk_enrollment_course
                    FOREIGN KEY (course_id) REFERENCES Course(course_id)
            );

            -- 2. Insert sample records
            INSERT INTO Department VALUES
            (10, 'CSE', 'Block A'),
            (20, 'ECE', 'Block B'),
            (30, 'IT', 'Block C'),
            (40, 'MECH', 'Block D');

            INSERT INTO Student VALUES
            (101, 'Anu', 10, 8.70),
            (102, 'Bala', 10, 7.90),
            (103, 'Charan', 20, 8.20),
            (104, 'Divya', 30, 9.10),
            (105, 'Esha', NULL, 7.50);

            INSERT INTO Course VALUES
            (501, 'DBMS', 10, 4),
            (502, 'Data Structures', 10, 4),
            (503, 'Digital Systems', 20, 3),
            (504, 'Web Technology', 30, 3);

            INSERT INTO Enrollment VALUES
            (1, 101, 501, 5, 88),
            (2, 101, 502, 5, 91),
            (3, 102, 501, 5, 76),
            (4, 103, 503, 5, 84),
            (5, 104, 504, 5, 95);

            -- 3. JOIN queries

            -- 3.1 Students with their department names (INNER JOIN)
            SELECT s.student_id, s.student_name, d.dept_name
            FROM Student AS s
            INNER JOIN Department AS d ON s.dept_id = d.dept_id;

            -- 3.2 All students, including those without a department (LEFT JOIN)
            SELECT s.student_id, s.student_name, d.dept_name
            FROM Student AS s
            LEFT JOIN Department AS d ON s.dept_id = d.dept_id;

            -- 3.3 All departments and their students (LEFT JOIN)
            SELECT d.dept_id, d.dept_name, s.student_name
            FROM Department AS d
            LEFT JOIN Student AS s ON d.dept_id = s.dept_id
            ORDER BY d.dept_id, s.student_id;

            -- 3.4 Students and the courses they enrolled in
            SELECT s.student_name, c.course_name, e.marks
            FROM Enrollment AS e
            INNER JOIN Student AS s ON e.student_id = s.student_id
            INNER JOIN Course AS c ON e.course_id = c.course_id
            ORDER BY s.student_id;

            -- 3.5 Students who scored more than 80
            SELECT s.student_name, c.course_name, e.marks
            FROM Enrollment AS e
            INNER JOIN Student AS s ON e.student_id = s.student_id
            INNER JOIN Course AS c ON e.course_id = c.course_id
            WHERE e.marks > 80
            ORDER BY e.marks DESC;

            -- 3.6 RIGHT JOIN: all departments and any matching students
            SELECT d.dept_name, s.student_name
            FROM Student AS s
            RIGHT JOIN Department AS d ON s.dept_id = d.dept_id
            ORDER BY d.dept_id, s.student_id;

            -- 4. Sub-query examples

            -- 4.1 Students with CGPA greater than the average CGPA
            SELECT student_id, student_name, cgpa
            FROM Student
            WHERE cgpa > (SELECT AVG(cgpa) FROM Student);

            -- 4.2 Students belonging to the CSE department using a sub-query
            SELECT student_id, student_name
            FROM Student
            WHERE dept_id = (
                SELECT dept_id
                FROM Department
                WHERE dept_name = 'CSE'
            );

            -- 4.3 Students enrolled in the DBMS course
            SELECT student_id, student_name
            FROM Student
            WHERE student_id IN (
                SELECT student_id
                FROM Enrollment
                WHERE course_id = (
                    SELECT course_id
                    FROM Course
                    WHERE course_name = 'DBMS'
                )
            );

            -- 4.4 Courses whose credits are greater than at least one course in ECE (ANY)
            SELECT course_id, course_name, credits
            FROM Course
            WHERE credits > ANY (
                SELECT credits
                FROM Course
                WHERE dept_id = 20
            );

            -- 4.5 Correlated sub-query: students whose CGPA is above their department average
            SELECT s.student_id, s.student_name, s.dept_id, s.cgpa
            FROM Student AS s
            WHERE s.dept_id IS NOT NULL
            AND s.cgpa > (
                SELECT AVG(s2.cgpa)
                FROM Student AS s2
                WHERE s2.dept_id = s.dept_id
            );

            -- 4.6 Student(s) with the highest CGPA
            SELECT student_id, student_name, cgpa
            FROM Student
            WHERE cgpa = (SELECT MAX(cgpa) FROM Student);
