/***********************************************************************
Table Of Content
   - CRUD Operation
   - Update table fileds name, type and value.
   - Subquery understanding
         `D:\Jilani\learning\sql\query\query\query-2.md`
   - Some of the interview questions
		 `D:\Jilani\learning\sql\Interview\interview-answers\coding-answers\sql-coding-answer_2.md`


*************************************************************************/


-----*******************************************
------ CREATE TABLE
CREATE TABLE employee (
     
    email VARCHAR(100) PRIMARY KEY,
    username VARCHAR(50),
    salary DOUBLE PRECISION,
    gender VARCHAR(10),
    dob DATE
);
------

-----*******************************************
---- UPDATE Fields name and Filed's Value
ALTER TABLE employee
RENAME COLUMN dob TO doj;

ALTER TABLE employee
DROP CONSTRAINT employee_pkey;

ALTER TABLE employee
ADD COLUMN id SERIAL PRIMARY KEY;

UPDATE employee
SET gender = 'Male'
WHERE email = 'john.doe@gmail.com';
--------

-----*******************************************
----- INSERT INTO TABLE
INSERT INTO employee (email, username, salary, gender, doj)
VALUES 
('john.doe@gmail.com', 'John', 55000.50, 'Male', '2020-04-12'),

('sarah.khan@gmail.com', 'Sarah', 62000.00, 'Female', '2021-07-25'),

('amit.sharma@gmail.com', 'Amit', 48000.75, 'Male', '2022-11-03'),

('fatima.ali@gmail.com', 'Fatima', 71000.00, 'Female', '2023-02-18'),

('raj.verma@gmail.com', 'Raj', 53000.20, 'Male', '2024-09-30');


INSERT INTO employee (email, username, salary, gender, doj)
VALUES 
('john.doe@gmail.com', 'John', 80000, 'Male', '2021-04-12');
------


SELECT * FROM employee;


-----*******************************************
------ Total extra duplicate rows, Excludes the first occurrence
SELECT COUNT(*) AS extra_duplicates
FROM employee e1
WHERE EXISTS (
    SELECT 1
    FROM employee e2
    WHERE e1.email = e2.email
    AND e1.id > e2.id
);
--

-----*******************************************
-- Unique rows based on email, so only email per row, exclude the row which has email more than once(duplicate email)
SELECT * 
FROM employee
WHERE email IN(
	  SELECT email
	  FROM employee
	  GROUP By email
	  HAVING COUNT(*) = 1
)

SELECT DISTINCT email
FROM employee;
--

-----*******************************************
-- Duplicate rows based on email, so gets row which appears more than once based on email
SELECT * 
FROM employee
WHERE email IN(
	  SELECT email
	  FROM employee
	  GROUP By email
	  HAVING COUNT(*) > 1
)

SELECT email, COUNT(*) As duplicate_count
FROM employee
GROUP By email
HAVING COUNT(*) > 1
--

-----*******************************************
-- Keep One Record and DELETE other duplicated record, so only unique record will be there after this query 
DELETE FROM employee e1
WHERE EXISTS (
    SELECT 1
    FROM employee e2
    WHERE e1.email = e2.email
    AND e1.id > e2.id
);

--------


































