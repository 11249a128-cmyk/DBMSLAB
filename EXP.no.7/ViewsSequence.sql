                           **// Creation of Views, Sequence, Index and Savepoint //**

🕒PROGRAM :
            -- 1. Create STUDENT table
            CREATE TABLE STUDENT (
                ROLLNO NUMBER(5) PRIMARY KEY,
                NAME VARCHAR2(30),
                DEPARTMENT VARCHAR2(20),
                MARKS NUMBER(3)
            );

            -- 2. Insert sample records
            INSERT INTO STUDENT VALUES (101, 'ARUN', 'CSE', 85);
            INSERT INTO STUDENT VALUES (102, 'PRIYA', 'ECE', 90);
            INSERT INTO STUDENT VALUES (103, 'KUMAR', 'CSE', 78);
            INSERT INTO STUDENT VALUES (104, 'DIVYA', 'IT', 88);
            INSERT INTO STUDENT VALUES (105, 'RAHUL', 'CSE', 92);

            COMMIT;

            -- 3. Create a View
            CREATE VIEW CSE_STUDENTS AS
            SELECT ROLLNO, NAME, MARKS
            FROM STUDENT
            WHERE DEPARTMENT = 'CSE';

            -- Display View
            SELECT * FROM CSE_STUDENTS;

            -- Drop View
            DROP VIEW CSE_STUDENTS;

            -- 4. Create Sequence
            CREATE SEQUENCE STUDENT_SEQ
            START WITH 106
            INCREMENT BY 1
            NOCACHE
            NOCYCLE;

            -- Generate sequence values
            SELECT STUDENT_SEQ.NEXTVAL FROM DUAL;
            SELECT STUDENT_SEQ.NEXTVAL FROM DUAL;

            -- Insert using Sequence
            -- After the two NEXTVAL calls, the next value is 108
            INSERT INTO STUDENT
            VALUES (STUDENT_SEQ.NEXTVAL, 'SNEHA', 'CSE', 89);

            COMMIT;

            -- Display Student records
            SELECT * FROM STUDENT;

            -- 5. Create Index
            CREATE INDEX IDX_STUDENT_NAME
            ON STUDENT(NAME);

            -- Search using indexed column
            SELECT * FROM STUDENT
            WHERE NAME = 'ARUN';

            -- Drop Index
            DROP INDEX IDX_STUDENT_NAME;

            -- 6. SAVEPOINT and ROLLBACK

            -- Insert MOHAN
            INSERT INTO STUDENT
            VALUES (106, 'MOHAN', 'IT', 80);

            -- Create Savepoint
            SAVEPOINT SP1;

            -- Insert LATHA
            INSERT INTO STUDENT
            VALUES (107, 'LATHA', 'ECE', 87);

            -- Display records before rollback
            SELECT * FROM STUDENT;

            -- Roll back changes after SP1
            ROLLBACK TO SP1;

            -- Save remaining changes
            COMMIT;

            -- Display final records
            SELECT * FROM STUDENT;

            -- Drop Sequence
            DROP SEQUENCE STUDENT_SEQ;
