⏺️ ➡️ 🟦 🔵 🟢 🔴 ⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

# ⏺️ SQL Coding

## ➡️ Find students and teacher name from pune studying in class 10 section c and subject in Math.

```sql

 SELECT
    s.name AS student_name,
    sub.teacher AS teacher_name
FROM Student s
JOIN Class c
    ON s.classId = c.classId
JOIN Section sec
    ON c.roomNo = sec.roomNo
JOIN Subject sub
    ON s.subjectId = sub.subjectId
WHERE
    s.address = 'Pune'
    AND c.class = '10'
    AND sec.section = 'C'
    AND sub.subject = 'Math';
```

## ➡️ finding the second highest salary value of the given table in the sql query using postgresql.

##### 🟦 Way 1 ORDER BY + OFFSET + LIMIT (most common & clean)

```sql
SELECT DISTINCT salary
FROM employee
ORDER BY salary DESC
OFFSET 1
LIMIT 1;

```

##### 🟦 Way 2: Subquery with MAX

- But since `MAX()` only cares about the largest value,
  duplicates don’t change the result.

```sql
SELECT MAX(salary) AS second_highest_salary
FROM employee
WHERE salary < (
    SELECT MAX(salary)
    FROM employee
);

```

##### 🟦

```sql

```

##### 🟦

```sql

```

## ➡️ You have two tables. Write a query using INNER JOIN to retrieve data. You can use any example data for this.

##### 🟦 Way 1: Standard INNER JOIN

```sql
  SELECT e.emp_id, e.name, d.dept_name
FROM employee e
INNER JOIN department d
ON e.dept_id = d.dept_id;

```

##### 🟦 Way 2: JOIN (same as INNER JOIN)

```sql
SELECT e.emp_id, e.name, d.dept_name
FROM employee e
JOIN department d
ON e.dept_id = d.dept_id;

```

## ➡️ Finding the duplicated records in a table. How many duplicates records are there in the table

##### 🟦 Way 1: Find duplicate values

```sql
SELECT email, COUNT(*) AS duplicate_count
FROM users
GROUP BY email
HAVING COUNT(*) > 1;

```

##### 🟦 Way 2: Count total duplicate rows

```sql
SELECT SUM(cnt - 1) AS total_duplicates
FROM (
    SELECT COUNT(*) AS cnt
    FROM users
    GROUP BY email
    HAVING COUNT(*) > 1
) t;

```

##### 🟦 Way 3: Find full duplicate rows

```sql
  SELECT *
FROM users u
WHERE u.email IN (
    SELECT email
    FROM users
    GROUP BY email
    HAVING COUNT(*) > 1
);

```

## ➡️ You have a user table with 50 records. Write a query to retrieve 20 records starting from the 5th row. The result should include the user's first name and last name.

##### 🟦 Way 1: OFFSET + LIMIT (most common)

```sql
SELECT first_name, last_name
FROM users
ORDER BY id
OFFSET 4
LIMIT 20;

```

##### 🟦 Way 2: LIMIT … OFFSET

```sql
SELECT first_name, last_name
FROM users
ORDER BY id
LIMIT 20 OFFSET 4;

```

##### 🟦 Way 3: Using ROW_NUMBER() (advanced & flexible)

```sql
SELECT first_name, last_name
FROM (
    SELECT first_name, last_name,
           ROW_NUMBER() OVER (ORDER BY id) AS rn
    FROM users
) t
WHERE rn BETWEEN 5 AND 24;

```

##### 🟦

```sql

```
