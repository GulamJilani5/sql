⏺️ ➡️ 🟦 🔵 🟢 🔴 ⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

# ⏺️ Finding the duplicated records

```sql
| id | name  | email       |
| -- | ----- | ----------- |
| 1  | Alice | a@gmail.com |
| 2  | Bob   | b@gmail.com |
| 3  | Carol | c@gmail.com |
| 4  | Alice | a@gmail.com |
| 5  | David | d@gmail.com |
| 6  | Carol | c@gmail.com |
| 7  | Carol | c@gmail.com |

```

### ➡️ Find entire rows where email appears more than once

- for example all the rows having email more than once and excluding those rows which are appearing only once

```sql
SELECT *
FROM employee
WHERE email IN(
	  SELECT email
	  FROM employee
	  GROUP By email
	  HAVING COUNT(*) > 1
)
```

```sql
SELECT *
FROM employee emp
WHERE emp.email IN(
	  SELECT email
	  FROM employee
	  GROUP By email
	  HAVING COUNT(*) > 1
)
ORDER BY email;
```

```sql
| id | name  | email       |
|----|-------|-------------|
| 1  | Alice | a@gmail.com |
| 4  | Alice | a@gmail.com |
| 3  | Carol | c@gmail.com |
| 6  | Carol | c@gmail.com |
| 7  | Carol | c@gmail.com |
```

##### 🟦 Duplicate values & their counts

```sql
SELECT email, COUNT(*)
FROM employees
GROUP BY email
HAVING COUNT(*) > 1;
```

```sql
| email       | count |
|-------------|-------|
| a@gmail.com | 2     |
| c@gmail.com | 3     |
```

##### 🟦 How many duplicate records are there?

```sql
SELECT COUNT(*) AS total_duplicate_rows
FROM (
    SELECT email
    FROM employees
    GROUP BY email
    HAVING COUNT(*) > 1
) sub;
```

```sql
| total_duplicate_rows |
|------------------------|
| 2                      |
```
