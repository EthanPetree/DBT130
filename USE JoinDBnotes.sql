USE JoinDB
GO

SELECT * FROM Employees;
SELECT * FROM Tasks;

-- list employees and their tasks
-- lazy way
SELECT * 
FROM Employees, Tasks
WHERE Employees.EmployeeId = Tasks.EmployeeId;

-- better way
SELECT *
FROM Employees
INNER JOIN Tasks
    ON Employees.EmployeeId = Tasks.EmployeeId;
--4 rows

-- list all employees with or without taks
SELECT *
FROM Employees
LEFT OUTER JOIN Tasks
    ON Employees.EmployeeId = Tasks.EmployeeId;

-- list all taks with or without employees
SELECT *
FROM Tasks
LEFT OUTER JOIN Employees
    ON Employees.EmployeeId = Tasks.EmployeeId;

SELECT *
FROM Employees
RIGHT OUTER JOIN Tasks
    ON Employees.EmployeeId = Tasks.EmployeeId;

--list all records
SELECT * From Employees
FULL OUTER JOIN Tasks
    ON Employees.EmployeeId = Tasks.EmployeeId;

-- list employee id, first name, last name, task name
SELECT e.EmployeeId, FirstName, LastName, TaskName
FROM Employees as e
INNER JOIN Tasks as t
    ON e.EmployeeId = t.EmployeeId;

--list employees without tasks
SELECT e.EmployeeId, FirstName, LastName, TaskName
FROM Employees as e
LEFT OUTER JOIN Tasks as t
    ON e.EmployeeId = t.EmployeeId
    WHERE t.TaskId IS NULL;
-- 8 

-- list all tasks without employees
SELECT e.EmployeeId, FirstName, LastName, TaskName
FROM Employees as e
RIGHT OUTER JOIN Tasks as t
    ON e.EmployeeId = t.EmployeeId
    WHERE t.EmployeeId IS NULL;
-- 3 tasks

-- list all employees without tasks 
-- and last name starts with S
SELECT e.EmployeeId, FirstName, LastName, TaskName
FROM Employees as e
LEFT OUTER JOIN Tasks as t
    ON e.EmployeeId = t.EmployeeId
    WHERE t.TaskId IS NULL
    AND e.LastName LIKE 'S%'; -- LIKE and NOT LIKE for string operations
-- 3

-- list all employees with tasks and "
SELECT e.EmployeeId, FirstName, LastName, TaskName
FROM Employees as e
LEFT OUTER JOIN Tasks as t
    ON e.EmployeeId = t.EmployeeId
    WHERE t.TaskId IS NOT NULL
    AND e.LastName LIKE 'S%';
    --2

-- sorting
--sort the list of employees by how many hours they are scheduled to work
SELECT e.FirstName, e.LastName, t.TaskName, t.EstimatedHours, t.EstimatedHours - t.WorkedHours as 'Hours Worked'
FROM Employees as e
LEFT OUTER JOIN Tasks as t
    ON e.EmployeeId = t.EmployeeId
WHERE t.EstimatedHours IS NOT NULL AND t.EstimatedHours > t.WorkedHours
ORDER BY [Hours Worked] DESC;

--list all possible combinations of employess and tasks
SELECT e.EmployeeId, e.FirstName, e.LastName, t.TaskName
FROM Employees as e
CROSS JOIN Tasks as t
ORDER BY EmployeeId;