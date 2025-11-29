# Answer 1

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
