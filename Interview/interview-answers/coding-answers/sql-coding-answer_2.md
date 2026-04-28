⏺️ ➡️ 🟦 🔵 🟢 🔴 ⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

### ➡️ You have a user table with 50 records. Write a query to retrieve 20 records starting from the 5th row. The result should include the user's first name and last name.

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

### ➡️ Find students and teacher name from pune studying in class 10 section c and subject in Math.

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

### ➡️ You have two tables. Write a query using INNER JOIN to retrieve data. You can use any example data for this.

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
