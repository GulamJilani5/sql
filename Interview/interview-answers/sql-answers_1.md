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

## ➡️ You have two tables. Write a query using INNER JOIN to retrieve data. You can use any example data for this.

## ➡️ Finding the duplicated records in a table. How many duplicates records are there in the table

## ➡️ You have a user table with 50 records. Write a query to retrieve 20 records starting from the 5th row. The result should include the user's first name and last name.
