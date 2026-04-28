⏺️ ➡️ 🟦 🔵 🟢 🔴 ⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

# ⏺️ Finding the duplicated records

```sql
CREATE TABLE employee (
    email VARCHAR(100) PRIMARY KEY,
    username VARCHAR(50),
    salary DOUBLE PRECISION,
    gender VARCHAR(10),
    doj DATE
);
```

### ➡️ Return duplicate records

- for example all the records which has same email more than one will return here

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

### ➡️ Total extra duplicate rows, Excludes the first occurrence

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

##### 🟦 **SUM(count - 1):** How many extra duplicate rows exist in total(excluding original)?

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

##### 🟦 Find Duplicate Email Values

- ##### 🔵 **GROUP BY:** Duplicate values + their counts

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

- ##### 🔵 How many duplicate records are there?

```sql
SELECT COUNT(*) AS total_duplicate_groups
FROM (
    SELECT email
    FROM employees
    GROUP BY email
    HAVING COUNT(*) > 1
) sub;
```

#### 🟦 Get Full Duplicate Rows

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
