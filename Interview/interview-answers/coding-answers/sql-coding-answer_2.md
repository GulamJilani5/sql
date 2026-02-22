⏺️ ➡️ 🟦 🔵 🟢 🔴 ⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

# ➡️ Finding the duplicated records

### 🟦 Total extra duplicate rows, Excludes the first occurrence

**EXISTS:** Total number of extra duplicate rows

- All duplicate rows except the first occurrence
- correlated subquery

```sql
WHERE EXISTS ( subquery )
```

```sql
SELECT COUNT(*) AS extra_duplicates
FROM employees e1
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e1.email = e2.email
    AND e1.id > e2.id
);
```

- Execution order conceptually:
  - Take first row of e1
  - Run subquery using that row’s values
  - Check EXISTS
  - Move to next row
  - Repeat

##### 🔵 **SUM(count - 1):** How many extra duplicate rows exist in total(excluding original)?

- When you put a subquery inside `FROM`,
- you MUST give it an alias. 🔴
- here alias name is sub;

```sql
SELECT SUM(count - 1) AS extra_duplicates
FROM (
    SELECT COUNT(*) as count
    FROM employees
    GROUP BY email
    HAVING COUNT(*) > 1
) sub;
```

- Execution Order
  - Run inner query first
  - Get result set (counts)
  - Treat it like a temporary table named sub
  - Outer query runs on that result

- **Duplicates:**
  - A → 3 rows → extra = 2
  - B → 2 rows → extra = 1
- Total extra duplicates = 3
- **Output:**
  - extra_duplicates: 3

### 🟦 Find Duplicate Email Values

##### 🔵 **GROUP BY:** Duplicate values + their counts

```sql
SELECT email, COUNT(*)
FROM employees
GROUP BY email
HAVING COUNT(*) > 1;
```

- `GROUP BY` email → groups same emails
- `COUNT(*)` → counts how many times each email appears
- `HAVING COUNT(*) > 1` → only show duplicates
- **Example Data**
  | id | email |
  | -- | ----- |
  | 1 | A |
  | 2 | A |
  | 3 | A |
  | 4 | B |
  | 5 | B |
  | 6 | C |
- **Output:**
  | email | count |
  | ----- | ----- |
  | A | 3 |
  | B | 2 |
- A appears 3 times
- B appears 2 times
- C is ignored
- This shows duplicate values and their frequency.

##### 🔵 How many duplicate records are there?

```sql
SELECT COUNT(*) AS total_duplicate_groups
FROM (
    SELECT email
    FROM employees
    GROUP BY email
    HAVING COUNT(*) > 1
) sub;
```

### 🟦 Get Full Duplicate Rows

- Only shows the duplicate rows but it does NOT directly tell how many duplicates exist per value.

```sql
SELECT *
FROM employees
WHERE email IN (
    SELECT email
    FROM employees
    GROUP BY email
    HAVING COUNT(*) > 1
)
ORDER BY email;
```

# ➡️ Find Unique Records

### 🟦 Records That Appear Only Once

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

### 🟦 Get Only Distinct Values (Remove duplicates in result)

```sql
SELECT DISTINCT email
FROM employees;
```

- This removes duplicate values from output.

### 🟦 Count of Unique (Non-Duplicate)

```sql
SELECT COUNT(*)
FROM (
    SELECT email
    FROM employees
    GROUP BY email
    HAVING COUNT(*) = 1
) t;
```

### 🟦 Count of Distinct Emails (Regardless of Duplicates)

```sql
SELECT COUNT(DISTINCT email)
FROM employees;
```

# ➡️ Remove Duplicate Records

### 🟦 Delete Using USING Clause(DELETE Duplicate records and Keep One Record)

- `USING` is only in the Postgresql

```sql
DELETE FROM employees e1
USING employees e2
WHERE e1.id > e2.id
AND e1.email = e2.email;
```

- This keeps the lowest id and deletes others.

### 🟦 Delete Using EXISTS Operator(DELETE Duplicate records and Keep One Record)

```sql
DELETE FROM employees e1
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e1.email = e2.email
    AND e1.id > e2.id
);
```

- - This keeps the lowest id and deletes others.

### 🟦 Keep One Record (Using CTE + ROW_NUMBER())

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
