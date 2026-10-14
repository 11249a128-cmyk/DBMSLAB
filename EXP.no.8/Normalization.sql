                                   **// Normalization in Oracle (1NF, 2NF, 3NF, 4NF, 5NF) using Functional Dependencies //**

🕒PROGRAM :
-- =========================
-- 1. UNNORMALIZED TABLE TO 1NF
-- =========================

CREATE TABLE StudentCourse_1NF (
    SID VARCHAR2(10),
    SName VARCHAR2(30),
    Course VARCHAR2(20),
    Faculty VARCHAR2(30),
    FacultyPhone VARCHAR2(15),
    Dept VARCHAR2(10),
    HOD VARCHAR2(30),
    CONSTRAINT pk_1nf PRIMARY KEY (SID, Course)
);

INSERT INTO StudentCourse_1NF VALUES ('S1','Arun','DBMS','Ravi','9990001','CSE','Dr. Sharma');
INSERT INTO StudentCourse_1NF VALUES ('S1','Arun','OS','Meena','9990002','CSE','Dr. Sharma');
INSERT INTO StudentCourse_1NF VALUES ('S2','Bala','DBMS','Ravi','9990001','CSE','Dr. Sharma');
COMMIT;

SELECT * FROM StudentCourse_1NF;

-- =========================
-- 2. SECOND NORMAL FORM (2NF)
-- =========================

CREATE TABLE Student (
    SID VARCHAR2(10) PRIMARY KEY,
    SName VARCHAR2(30)
);

CREATE TABLE Course_Faculty (
    Course VARCHAR2(20) PRIMARY KEY,
    Faculty VARCHAR2(30),
    FacultyPhone VARCHAR2(15),
    Dept VARCHAR2(10),
    HOD VARCHAR2(30)
);

CREATE TABLE Enrollment (
    SID VARCHAR2(10),
    Course VARCHAR2(20),
    PRIMARY KEY (SID, Course),
    FOREIGN KEY (SID) REFERENCES Student(SID),
    FOREIGN KEY (Course) REFERENCES Course_Faculty(Course)
);

INSERT INTO Student VALUES ('S1','Arun');
INSERT INTO Student VALUES ('S2','Bala');

INSERT INTO Course_Faculty VALUES ('DBMS','Ravi','9990001','CSE','Dr. Sharma');
INSERT INTO Course_Faculty VALUES ('OS','Meena','9990002','CSE','Dr. Sharma');

INSERT INTO Enrollment VALUES ('S1','DBMS');
INSERT INTO Enrollment VALUES ('S1','OS');
INSERT INTO Enrollment VALUES ('S2','DBMS');
COMMIT;

SELECT * FROM Student;
SELECT * FROM Course_Faculty;
SELECT * FROM Enrollment;

-- =========================
-- 3. THIRD NORMAL FORM (3NF)
-- =========================

CREATE TABLE Department (
    Dept VARCHAR2(10) PRIMARY KEY,
    HOD VARCHAR2(30)
);

CREATE TABLE Faculty_Dept (
    Faculty VARCHAR2(30) PRIMARY KEY,
    FacultyPhone VARCHAR2(15),
    Dept VARCHAR2(10),
    FOREIGN KEY (Dept) REFERENCES Department(Dept)
);

CREATE TABLE Course_3NF (
    Course VARCHAR2(20) PRIMARY KEY,
    Faculty VARCHAR2(30),
    FOREIGN KEY (Faculty) REFERENCES Faculty_Dept(Faculty)
);

INSERT INTO Department VALUES ('CSE','Dr. Sharma');
INSERT INTO Faculty_Dept VALUES ('Ravi','9990001','CSE');
INSERT INTO Faculty_Dept VALUES ('Meena','9990002','CSE');
INSERT INTO Course_3NF VALUES ('DBMS','Ravi');
INSERT INTO Course_3NF VALUES ('OS','Meena');
COMMIT;

SELECT c.Course, f.Faculty, f.FacultyPhone, f.Dept, d.HOD
FROM Course_3NF c
JOIN Faculty_Dept f ON c.Faculty = f.Faculty
JOIN Department d ON f.Dept = d.Dept;

-- =========================
-- 4. FOURTH NORMAL FORM (4NF)
-- =========================

CREATE TABLE Faculty_Course (
    Faculty VARCHAR2(30),
    Course VARCHAR2(20),
    PRIMARY KEY (Faculty, Course)
);

CREATE TABLE Faculty_Language (
    Faculty VARCHAR2(30),
    Language VARCHAR2(20),
    PRIMARY KEY (Faculty, Language)
);

INSERT INTO Faculty_Course VALUES ('Ravi','DBMS');
INSERT INTO Faculty_Course VALUES ('Ravi','OS');
INSERT INTO Faculty_Language VALUES ('Ravi','English');
INSERT INTO Faculty_Language VALUES ('Ravi','Hindi');
COMMIT;

SELECT * FROM Faculty_Course;
SELECT * FROM Faculty_Language;

-- =========================
-- 5. FIFTH NORMAL FORM (5NF)
-- =========================

CREATE TABLE Faculty_Course_5NF (
    Faculty VARCHAR2(30),
    Course VARCHAR2(20),
    PRIMARY KEY (Faculty, Course)
);

CREATE TABLE Course_Textbook_5NF (
    Course VARCHAR2(20),
    Textbook VARCHAR2(30),
    PRIMARY KEY (Course, Textbook)
);

CREATE TABLE Faculty_Textbook_5NF (
    Faculty VARCHAR2(30),
    Textbook VARCHAR2(30),
    PRIMARY KEY (Faculty, Textbook)
);

INSERT INTO Faculty_Course_5NF VALUES ('Ravi','DBMS');
INSERT INTO Faculty_Course_5NF VALUES ('Meena','OS');

INSERT INTO Course_Textbook_5NF VALUES ('DBMS','Korth');
INSERT INTO Course_Textbook_5NF VALUES ('DBMS','Navathe');
INSERT INTO Course_Textbook_5NF VALUES ('OS','Silberschatz');

INSERT INTO Faculty_Textbook_5NF VALUES ('Ravi','Korth');
INSERT INTO Faculty_Textbook_5NF VALUES ('Ravi','Navathe');
INSERT INTO Faculty_Textbook_5NF VALUES ('Meena','Silberschatz');
COMMIT;

SELECT fc.Faculty, fc.Course, ct.Textbook
FROM Faculty_Course_5NF fc
JOIN Course_Textbook_5NF ct ON fc.Course = ct.Course
JOIN Faculty_Textbook_5NF ft
  ON fc.Faculty = ft.Faculty
 AND ct.Textbook = ft.Textbook;

-- =========================
-- 6. VERIFY TABLES AND CONSTRAINTS
-- =========================

SELECT table_name FROM user_tables;

DESC Faculty_Dept;

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name IN
('STUDENT','COURSE_3NF','FACULTY_DEPT','DEPARTMENT');

SELECT a.table_name, a.column_name, c.constraint_type
FROM user_cons_columns a
JOIN user_constraints c
  ON a.constraint_name = c.constraint_name
WHERE c.constraint_type IN ('P','R')
ORDER BY a.table_name;
