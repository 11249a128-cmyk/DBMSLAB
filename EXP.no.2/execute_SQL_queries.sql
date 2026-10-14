                              **// Performing Insertion, Deletion, Modifying, Updating, Altering and  Viewing records based on conditions//**

🕒PROGRAM : 
            CREATE DATABASE CompanyDB;
            USE CompanyDB;

            -- Create Sample Table
            CREATE TABLE Employee (
                EmpID INT PRIMARY KEY,
                Name VARCHAR(50),
                Department VARCHAR(30),
                Salary DECIMAL(10,2),
                JoinDate DATE
            );

            -- 1. Insertion: Insert a Single Record
            INSERT INTO Employee
            (EmpID, Name, Department, Salary, JoinDate)
            VALUES
            (101, 'Anjali Sharma', 'IT', 45000.00, '2023-06-15');

            -- Insert Multiple Records
            INSERT INTO Employee
            (EmpID, Name, Department, Salary, JoinDate)
            VALUES
            (102, 'Ravi Kumar', 'HR', 38000.00, '2022-03-10'),
            (103, 'Priya Singh', 'Finance', 52000.00, '2021-11-01'),
            (104, 'Karthik Iyer', 'IT', 47000.00, '2023-01-20');

            -- 2. View All Records
            SELECT * FROM Employee;

            -- View IT Employees
            SELECT * FROM Employee
            WHERE Department = 'IT';

            -- View Employees Earning More Than 40000
            SELECT Name, Salary FROM Employee
            WHERE Salary > 40000;

            -- View IT Employees Earning At Least 45000
            SELECT * FROM Employee
            WHERE Department = 'IT' AND Salary >= 45000;

            -- View Employees with Salary Between 40000 and 50000
            SELECT * FROM Employee
            WHERE Salary BETWEEN 40000 AND 50000;

            -- View Employees in IT or Finance
            SELECT * FROM Employee
            WHERE Department IN ('IT', 'Finance');

            -- View Employees Whose Names Start with A
            SELECT * FROM Employee
            WHERE Name LIKE 'A%';

            -- Sort IT Employees by Salary in Descending Order
            SELECT * FROM Employee
            WHERE Department = 'IT'
            ORDER BY Salary DESC;

            -- 3. Update Salary of Employee 101
            UPDATE Employee
            SET Salary = 48000.00
            WHERE EmpID = 101;

            SELECT * FROM Employee WHERE EmpID = 101;

            -- Update IT Employee Salaries and Department
            UPDATE Employee
            SET Salary = Salary + 2000,
                Department = 'Systems'
            WHERE Department = 'IT';

            SELECT * FROM Employee;

            -- 4. Delete a Specific Employee
            DELETE FROM Employee
            WHERE EmpID = 102;

            -- 5. Delete Employees Earning Less Than 40000
            DELETE FROM Employee
            WHERE Salary < 40000;

            -- View Remaining Employees
            SELECT * FROM Employee;

            -- 6. Add Email Column
            ALTER TABLE Employee
            ADD Email VARCHAR(100);

            -- 7. Modify Name Column Size (MySQL)
            ALTER TABLE Employee
            MODIFY COLUMN Name VARCHAR(80);

            -- 8. Rename Email Column
            ALTER TABLE Employee
            RENAME COLUMN Email TO ContactEmail;

            -- 9. Drop ContactEmail Column
            ALTER TABLE Employee
            DROP COLUMN ContactEmail;

            -- 10. Rename the Table
            ALTER TABLE Employee
            RENAME TO Staff;

            -- View Final Table Structure
            DESCRIBE Staff;

            -- View Final Records
            SELECT * FROM Staff;
