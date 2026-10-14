                              **//Queries Using ANY, ALL, IN, EXISTS, NOT EXISTS, UNION, INTERSECT and Constraints //**

🕒PROGRAM :
            CREATE DATABASE IF NOT EXISTS CollegeDB;
            USE CollegeDB;

            DROP TABLE IF EXISTS Enrollment;
            DROP TABLE IF EXISTS Course;
            DROP TABLE IF EXISTS Student;
            DROP TABLE IF EXISTS Department;

            -- 1. Create Department table
            CREATE TABLE Department (
                dept_id INT PRIMARY KEY,
                dept_name VARCHAR(50) NOT NULL UNIQUE
            );

            -- 2. Create Student table
            CREATE TABLE Student (
                roll_no INT PRIMARY KEY,
                name VARCHAR(50) NOT NULL,
                age INT CHECK (age >= 17 AND age <= 30),
                email VARCHAR(50) UNIQUE,
                gender VARCHAR(10) DEFAULT 'Not Specified',
                dept_id INT,
                FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
            );

            -- 3. Create Course table
            CREATE TABLE Course (
                course_id INT PRIMARY KEY,
                course_name VARCHAR(50) NOT NULL,
                credits INT CHECK (credits BETWEEN 1 AND 6),
                dept_id INT,
                FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
            );

            -- 4. Create Enrollment table
            CREATE TABLE Enrollment (
                roll_no INT,
                course_id INT,
                marks INT CHECK (marks BETWEEN 0 AND 100),
                PRIMARY KEY (roll_no, course_id),
                FOREIGN KEY (roll_no) REFERENCES Student(roll_no),
                FOREIGN KEY (course_id) REFERENCES Course(course_id)
            );

            -- 5. Insert Department records
            INSERT INTO Department VALUES
            (1, 'Computer Science'),
            (2, 'Electronics'),
            (3, 'Mechanical');

            -- 6. Insert Student records
            INSERT INTO Student VALUES
            (101, 'Arun', 20, 'arun@email.com', 'Male', 1),
            (102, 'Priya', 21, 'priya@email.com', 'Female', 2),
            (103, 'Kumar', 22, 'kumar@email.com', 'Male', 1),
            (104, 'Sita', 19, 'sita@email.com', 'Female', 3),
            (105, 'Meena', 23, 'meena@email.com', 'Female', 2);

            -- 7. Insert Course records
            INSERT INTO Course VALUES
            (1, 'Data Structures', 4, 1),
            (2, 'Digital Circuits', 3, 2),
            (3, 'Thermodynamics', 4, 3),
            (4, 'DBMS', 4, 1);

            -- 8. Insert Enrollment records
            INSERT INTO Enrollment VALUES
            (101, 1, 85),
            (101, 4, 78),
            (102, 2, 60),
            (102, 4, 55),
            (103, 1, 90),
            (103, 4, 88),
            (104, 3, 70),
            (105, 2, 45);

            -- 9. IN: Students in CS or Mechanical
            SELECT name, dept_id
            FROM Student
            WHERE dept_id IN (
                SELECT dept_id
                FROM Department
                WHERE dept_name IN ('Computer Science', 'Mechanical')
            );

            -- 10. ANY: Marks greater than ANY mark in course 2
            SELECT DISTINCT s.name, e.marks
            FROM Student s
            JOIN Enrollment e ON s.roll_no = e.roll_no
            WHERE e.marks > ANY (
                SELECT marks
                FROM Enrollment
                WHERE course_id = 2
            );

            -- 11. ALL: Marks greater than ALL marks in course 2
            SELECT DISTINCT s.name, e.marks
            FROM Student s
            JOIN Enrollment e ON s.roll_no = e.roll_no
            WHERE e.marks > ALL (
                SELECT marks
                FROM Enrollment
                WHERE course_id = 2
            );

            -- 12. EXISTS: Departments having students
            SELECT dept_name
            FROM Department d
            WHERE EXISTS (
                SELECT 1
                FROM Student s
                WHERE s.dept_id = d.dept_id
            );

            -- 13. NOT EXISTS: Students not enrolled in any course
            SELECT name
            FROM Student s
            WHERE NOT EXISTS (
                SELECT 1
                FROM Enrollment e
                WHERE e.roll_no = s.roll_no
            );

            -- 14. UNION: Distinct roll numbers scoring above 80 in DBMS or Data Structures
            SELECT roll_no
            FROM Enrollment
            WHERE course_id = 4 AND marks > 80
            UNION
            SELECT roll_no
            FROM Enrollment
            WHERE course_id = 1 AND marks > 80;

            -- 15. INTERSECT equivalent in MySQL using IN subquery
            SELECT roll_no
            FROM Enrollment
            WHERE course_id = 1
            AND roll_no IN (
                SELECT roll_no
                FROM Enrollment
                WHERE course_id = 4
            );

            -- 16. EXCEPT / MINUS bonus: roll numbers in course 1 but not in course 4
            SELECT roll_no
            FROM Enrollment
            WHERE course_id = 1
            AND roll_no NOT IN (
                SELECT roll_no
                FROM Enrollment
                WHERE course_id = 4
            );

            -- 17. Constraint violation tests
            -- NOT NULL violation
            INSERT INTO Student
            VALUES (106, NULL, 22, 'test1@email.com', 'Male', 1);

            -- UNIQUE violation
            INSERT INTO Student
            VALUES (107, 'Ravi', 23, 'arun@email.com', 'Male', 1);

            -- CHECK violation
            INSERT INTO Enrollment
            VALUES (101, 2, 150);

            -- FOREIGN KEY violation
            INSERT INTO Enrollment
            VALUES (999, 1, 70);
