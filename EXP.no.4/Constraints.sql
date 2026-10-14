                              **// Create database to set various constraints //**

🕒PROGRAM :
            -- Step 1: Create database
            CREATE DATABASE IF NOT EXISTS CollegeDB;
            USE CollegeDB;

            -- Step 2: Drop old tables if they exist
            DROP TABLE IF EXISTS Student;
            DROP TABLE IF EXISTS Department;

            -- Step 3: Create Department table
            CREATE TABLE Department (
                dept_id INT PRIMARY KEY,
                dept_name VARCHAR(50) NOT NULL UNIQUE
            );

            -- Step 4: Create Student table with constraints
            CREATE TABLE Student (
                roll_no INT PRIMARY KEY,
                name VARCHAR(50) NOT NULL,
                age INT CHECK (age >= 17 AND age <= 30),
                email VARCHAR(50) UNIQUE,
                gender VARCHAR(10) DEFAULT 'Not Specified',
                dept_id INT,
                CONSTRAINT fk_student_department
                    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
            );

            -- Step 5: Insert records into Department
            INSERT INTO Department VALUES (1, 'Computer Science');
            INSERT INTO Department VALUES (2, 'Electronics');

            -- Step 6: Insert valid Student records
            INSERT INTO Student
                (roll_no, name, age, email, gender, dept_id)
            VALUES
                (101, 'Arun', 20, 'arun@email.com', 'Male', 1);

            INSERT INTO Student
                (roll_no, name, age, email, dept_id)
            VALUES
                (102, 'Priya', 21, 'priya@email.com', 2);

            -- Step 7: Display valid records
            SELECT * FROM Department;
            SELECT * FROM Student;

            -- Step 8: Test NOT NULL constraint
            INSERT INTO Student
            VALUES (103, NULL, 22, 'test1@email.com', 'Female', 1);

            -- Step 9: Test UNIQUE constraint
            INSERT INTO Student
            VALUES (104, 'Kumar', 23, 'arun@email.com', 'Male', 1);

            -- Step 10: Test PRIMARY KEY constraint
            INSERT INTO Student
            VALUES (101, 'Ravi', 22, 'ravi@email.com', 'Male', 1);

            -- Step 11: Test CHECK constraint
            INSERT INTO Student
            VALUES (105, 'Sita', 35, 'sita@email.com', 'Female', 1);

            -- Step 12: Test FOREIGN KEY constraint
            INSERT INTO Student
            VALUES (106, 'Meena', 20, 'meena@email.com', 'Female', 9);

            -- Step 13: Add a CHECK constraint
            ALTER TABLE Student
            ADD CONSTRAINT chk_name CHECK (CHAR_LENGTH(name) >= 3);

            -- Step 14: Drop the CHECK constraint in MySQL
            ALTER TABLE Student
            DROP CHECK chk_name;

            -- Step 15: View table structure and records
            DESCRIBE Student;
            SELECT * FROM Student;
