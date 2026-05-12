⏺️ ➡️ 🟦 🔵 🟢 🔴 ⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

# ⏺️ Find Unique Records

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

### ➡️ Unqiue rows by email(Records That Appear Only Once)

- Only record which is having email only once, those having email more than one will be excluded.
- Final output wise `delete-duplicate.md` will give the same result. `Delete all rows which are duplicates(Get only unique records)`
  - find `D:\Jilani\learning\sql\query\query\unique-duplicate-record\delete-duplicate.md`

```sql
SELECT *
FROM employees
WHERE email IN (
    SELECT email
    FROM employees
    GROUP BY email
    HAVING COUNT(*) = 1
);
```

- OR

```sql
SELECT *
FROM employees emp
WHERE emp.email IN (
    SELECT email
    FROM employees
    GROUP BY email
    HAVING COUNT(*) = 1
)
ORDER BY email;
```

- This gives records that are unique(not duplicated) like Bob & David

```sql
| id | name  | email       |
|----|-------|-------------|
| 2  | Bob   | b@gmail.com |
| 5  | David | d@gmail.com |
```

##### 🟦 Count

```sql
SELECT COUNT(*)
FROM (
    SELECT email
    FROM employees
    GROUP BY email
    HAVING COUNT(*) = 1
) t;
```

```sql
| count |
|-------|
| 2     |
```

### ➡️ Get Only Distinct email values (removing duplicated(extra) rows)

- If Email occurs 3 times then delete other 2 and keep only once.
- Final output wise `delete-duplicate.md` will give the same result. `removing duplicated(extra) rows (Get Only Distinct email values)`
  - find `D:\Jilani\learning\sql\query\query\unique-duplicate-record\delete-duplicate.md`

```sql
SELECT DISTINCT email
FROM employees;
```

```sql
| email       |
|-------------|
| a@gmail.com |
| b@gmail.com |
| c@gmail.com |
| d@gmail.com |
```

```sql
SELECT DISTINCT ON (email) *
FROM employees
ORDER BY email;
```

- All the records only once even if duplicated by removing duplicated(extra) rows.

```sql
| id | name  | email       |
|----|-------|-------------|
| 1  | Alice | a@gmail.com |
| 2  | Bob   | b@gmail.com |
| 3  | Carol | c@gmail.com |
| 5  | David | d@gmail.com |
```

##### 🟦 Count

```sql
SELECT COUNT(DISTINCT email)
FROM employees;
```

```sql
| count |
|-------|
| 4     |
```
