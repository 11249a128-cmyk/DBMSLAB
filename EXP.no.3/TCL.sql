                              **// Practicing DCL and TCL Commands //**

🕒PROGRAM : 
            -- Create Employee table
            CREATE TABLE Employee (
                EmpID INT PRIMARY KEY,
                Name VARCHAR(30),
                Department VARCHAR(20),
                Salary DECIMAL(10,2)
            );

            -- Insert records
            INSERT INTO Employee VALUES
            (101, 'Arun', 'HR', 35000),
            (102, 'Priya', 'IT', 45000),
            (103, 'Kavin', 'Finance', 50000),
            (104, 'Divya', 'IT', 55000);

            -- Grant permissions
            GRANT SELECT ON Employee TO user1;
            GRANT SELECT, INSERT ON Employee TO user1;

            -- Revoke permissions
            REVOKE INSERT ON Employee FROM user1;
            REVOKE ALL ON Employee FROM user1;

            -- Disable autocommit (MySQL)
            SET AUTOCOMMIT = 0;

            -- Update salary
            UPDATE Employee
            SET Salary = 48000
            WHERE EmpID = 102;

            -- Create savepoint
            SAVEPOINT SP1;

            -- Update another salary
            UPDATE Employee
            SET Salary = 60000
            WHERE EmpID = 104;

            -- Display records
            SELECT * FROM Employee;

            -- Roll back to savepoint
            ROLLBACK TO SP1;

            -- Commit changes
            COMMIT;

            -- Delete a record
            DELETE FROM Employee
            WHERE EmpID = 101;

            -- Roll back deletion
            ROLLBACK;

            -- Display final records
            SELECT * FROM Employee;
