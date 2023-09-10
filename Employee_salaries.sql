CREATE DATABASE Employee_Salaries;
USE Employee_Salaries;
DROP DATABASE Employee_Salaries;

CREATE TABLE Employee_Salaries (
ID INT,
Work_Year INT,
Experience_Level VARCHAR(10),
Employment_Type VARCHAR(20),
Job_Title VARCHAR(50),
Salary DECIMAL (10,2),
Salary_Currency VARCHAR(10),
Salary_in_USD DECIMAL (10,2),
Employee_Residence VARCHAR(50),
Remote_Ratio DECIMAL (10,2),
Company_Location VARCHAR(50),
Company_Size VARCHAR(10)
);
DROP TABLE Employee_Salaries;

SELECT * FROM Employee_Salaries;

WITH Cte as (
SELECT *, RANK() OVER (PARTITION BY Work_Year, Experience_Level, Employment_Type, Job_Title, Salary,
Salary_Currency, Salary_in_USD, Employee_Residence, Remote_Ratio, Company_Location, Company_Size) AS Duplicates
 FROM Employee_Salaries)
 SELECT * FROM Cte
 WHERE Duplicates >1;
 
SELECT Job_Title, COUNT(Job_Title)
FROM Employee_Salaries
WHERE Job_Title like '%data%' AND Job_Title like '%anal%'
GROUP BY 1;

SELECT Job_Title, COUNT(Job_Title)
FROM Employee_Salaries
WHERE Job_Title like '%data%' AND Job_Title like '%engi%'
GROUP BY 1;

SELECT Job_Title, COUNT(Job_Title)
FROM Employee_Salaries
WHERE Job_Title like '%data%' AND Job_Title like '%scien%'
GROUP BY 1;

SELECT Job_Title, COUNT(Job_Title) AS Number_of_Employees
FROM Employee_Salaries
GROUP BY 1
ORDER BY 2 DESC;

SELECT * FROM Employee_Salaries;

SELECT DISTINCT Experience_level FROM Employee_Salaries;

UPDATE Employee_Salaries
SET Experience_level = 'Mid'
WHERE Experience_level = 'MI';

UPDATE Employee_Salaries
SET Experience_level = 'Senior'
WHERE Experience_level = 'SE';

UPDATE Employee_Salaries
SET Experience_level = 'Entry'
WHERE Experience_level = 'EN';

UPDATE Employee_Salaries
SET Experience_level = 'Expert'
WHERE Experience_level = 'EX';

SELECT DISTINCT Employment_Type FROM Employee_Salaries;

UPDATE Employee_Salaries
SET Employment_Type = 'Full-time'
WHERE Employment_Type = 'FT';

UPDATE Employee_Salaries
SET Employment_Type = 'Part-time'
WHERE Employment_Type = 'PT';

UPDATE Employee_Salaries
SET Employment_Type = 'Freelance'
WHERE Employment_Type = 'FL';

UPDATE Employee_Salaries
SET Employment_Type = 'Contract Basis'
WHERE Employment_Type = 'CT';

SELECT * FROM Employee_Salaries;

UPDATE Employee_Salaries
SET Company_Size = 'Large'
WHERE Company_Size = 'L';

UPDATE Employee_Salaries
SET Company_Size = 'Medium'
WHERE Company_Size = 'M';

UPDATE Employee_Salaries
SET Company_Size = 'Small'
WHERE Company_Size = 'S';

SELECT Job_Title, AVG(Salary_in_USD) AS Avg_salary_in_USD FROM Employee_Salaries
GROUP BY 1
ORDER BY 2 DESC
;
SELECT Job_Title,Experience_level, AVG(Salary_in_USD) AS Avg_salary_in_USD FROM Employee_Salaries
GROUP BY 1,2
ORDER BY 1,2 DESC
;

SELECT Work_Year, Job_Title,Experience_level, AVG(Salary_in_USD) AS Avg_salary_in_USD FROM Employee_Salaries
GROUP BY 1,2,3
ORDER BY 1,2,3 DESC
;

SELECT Job_Title, COUNT(Job_Title) AS Number_of_Employees,Experience_level, 
CASE WHEN Remote_Ratio = 100 THEN 'full remote'
WHEN Remote_Ratio = 0 THEN 'full office'
END Remote
FROM Employee_Salaries
WHERE Remote_Ratio = 100 OR Remote_Ratio = 0
GROUP BY 1,3,4
ORDER BY 2 DESC;
;

SELECT Work_year, Job_Title,Experience_level, AVG(Salary_in_USD) AS Avg_salary_in_USD 
FROM Employee_Salaries
GROUP BY 1,2,3
ORDER BY 2
;

SELECT Job_Title, COUNT(Job_Title) AS Number_of_employees, Employee_Residence 
FROM Employee_Salaries
GROUP BY 1,3
ORDER BY 2 DESC;

WITH CTE AS (
SELECT Company_Size, AVG(Salary_in_USD) OVER (PARTITION BY
Company_Size) as Avg_Salary_in_USD
FROM Employee_Salaries)
SELECT Company_size, COUNT(Company_size) AS Number_of_companies, Avg_Salary_in_USD
FROM CTE
GROUP BY 1,3;

-- PREPARING DATA TO EXPORT FOR VISUALISATION PURPOSES

ALTER TABLE Employee_Salaries MODIFY Remote_Ratio VARCHAR (10);
UPDATE Employee_Salaries
SET Remote_Ratio = '0%'
WHERE Remote_Ratio = '0';
UPDATE Employee_Salaries
SET Remote_Ratio = '50%'
WHERE Remote_Ratio = '50';
UPDATE Employee_Salaries
SET Remote_Ratio = '100%'
WHERE Remote_Ratio = '100';
ALTER TABLE Employee_Salaries MODIFY Salary INT;
ALTER TABLE Employee_Salaries MODIFY Salary_in_USD INT;

SELECT * FROM Employee_Salaries;
