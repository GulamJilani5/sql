⏺️ ➡️ 🟦 🔵 🟢 🔴 ⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

# ⏺️ Find Unique Records

### ➡️ Records That Appear Only Once

- Only record which is having email only once, those having email more than one will be excluded.

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

- This gives records that are NOT duplicated.

### ➡️ Get Only Distinct emaail values (Remove duplicates in result)

```sql
SELECT DISTINCT email
FROM employees;
```

- This removes duplicate values from output.

### ➡️ Count of Unique (Non-Duplicate)

```sql
SELECT COUNT(*)
FROM (
    SELECT email
    FROM employees
    GROUP BY email
    HAVING COUNT(*) = 1
) t;
```

### ➡️ Count of Distinct Emails (Regardless of Duplicates)

```sql
SELECT COUNT(DISTINCT email)
FROM employees;
```

### ➡️ Remove Duplicate Records

##### 🟦 Delete Using USING Clause(DELETE Duplicate records and Keep One Record)

- `USING` is only in the Postgresql

```sql
DELETE FROM employees e1
USING employees e2
WHERE e1.id > e2.id
AND e1.email = e2.email;
```

- This keeps the lowest id and deletes others.

##### 🟦 Delete Using EXISTS Operator(DELETE Duplicate records and Keep One Record)

- Keep One Record and DELETE other duplicated record, so only unique record will be there after this query
- `EXISTS` works for all the sql.

```sql
DELETE FROM employees e1
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e1.email = e2.email
    AND e1.id > e2.id
);
```

- This keeps the lowest id and deletes others.

##### 🟦 Keep One Record (Using CTE + ROW_NUMBER())

- Best and safest method in PostgreSQL

```sql
WITH ranked AS (
    SELECT id,
           ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rn
    FROM employees
)
DELETE FROM employees
WHERE id IN (
    SELECT id FROM ranked WHERE rn > 1
);
```

- `PARTITION BY` email → groups duplicates
- `ROW_NUMBER()` → assigns:
- 1 to first row
- 2,3,4... to duplicates
- `DELETE WHERE rn > 1` → deletes duplicates
- Keeps only one record per email

### ➡️ Finding the duplicated records in a table. How many duplicates records are there in the table

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
