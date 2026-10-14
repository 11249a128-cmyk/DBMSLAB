                   **//  Queries Using Aggregate Functions, GROUP BY and HAVING Clause //**

🕒PROGRAM :
            -- 1. Create Employee table
            CREATE TABLE Employee (
                EmpID INT PRIMARY KEY,
                EmpName VARCHAR(50),
                Department VARCHAR(30),
                Designation VARCHAR(30),
                Salary DECIMAL(10,2),
                City VARCHAR(30),
                DOJ DATE
            );

            -- 2. Insert sample records
            INSERT INTO Employee VALUES
            (1, 'Aarav Sharma', 'IT', 'Developer', 55000, 'Chennai', '2021-03-15'),
            (2, 'Priya Nair', 'IT', 'Team Lead', 75000, 'Chennai', '2019-06-10'),
            (3, 'Rohit Verma', 'HR', 'Executive', 35000, 'Bangalore', '2022-01-20'),
            (4, 'Sneha Iyer', 'HR', 'Manager', 65000, 'Bangalore', '2018-11-05'),
            (5, 'Karthik Raj', 'Finance', 'Analyst', 45000, 'Chennai', '2020-07-01'),
            (6, 'Divya Menon', 'Finance', 'Manager', 70000, 'Mumbai', '2017-09-25'),
            (7, 'Arjun Das', 'IT', 'Developer', 58000, 'Mumbai', '2021-12-12'),
            (8, 'Fatima Khan', 'HR', 'Executive', 36000, 'Chennai', '2023-02-18'),
            (9, 'Vikram Singh', 'Finance', 'Analyst', 47000, 'Bangalore', '2022-05-30'),
            (10, 'Meera Pillai', 'IT', 'Developer', 59000, 'Bangalore', '2020-08-14');

            -- SAMPLE QUERIES

            -- 3. Count total employees
            SELECT COUNT(*) AS TotalEmployees
            FROM Employee;

            -- 4. Total salary paid
            SELECT SUM(Salary) AS TotalSalary
            FROM Employee;

            -- 5. Average salary
            SELECT AVG(Salary) AS AverageSalary
            FROM Employee;

            -- 6. Highest and lowest salary
            SELECT MAX(Salary) AS HighestSalary,
                MIN(Salary) AS LowestSalary
            FROM Employee;

            -- 7. Number of employees in each department
            SELECT Department, COUNT(*) AS EmpCount
            FROM Employee
            GROUP BY Department;

            -- 8. Department-wise average salary
            SELECT Department, AVG(Salary) AS AvgSalary
            FROM Employee
            GROUP BY Department
            ORDER BY AvgSalary DESC;

            -- 9. Departments with more than 3 employees
            SELECT Department, COUNT(*) AS EmpCount
            FROM Employee
            GROUP BY Department
            HAVING COUNT(*) > 3;

            -- 10. Departments with average salary above 50000
            SELECT Department, AVG(Salary) AS AvgSalary
            FROM Employee
            GROUP BY Department
            HAVING AVG(Salary) > 50000;

            -- 11. Combining WHERE, GROUP BY and HAVING
            SELECT Department, City, COUNT(*) AS EmpCount
            FROM Employee
            WHERE Salary > 40000
            GROUP BY Department, City
            HAVING COUNT(*) >= 2
            ORDER BY Department;

            -- 12. Cities spending above 100000 on salaries
            SELECT City, SUM(Salary) AS TotalSalary
            FROM Employee
            GROUP BY City
            HAVING SUM(Salary) > 100000;
