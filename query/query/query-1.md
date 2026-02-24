⏺️ ➡️ 🟦 🔵🟢🔴⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

# ⏺️ Aggregate Functions, GROUP BY & Having

## ➡️ Aggregate Functions

### 🟦 Core Aggregate Functions (Most Important)

##### 🔵 COUNT()

```sql
COUNT(*)              -- counts all rows (including NULLs)
COUNT(column)         -- counts non-null values
COUNT(DISTINCT column)
```

```sql
SELECT COUNT(*) FROM employees;
SELECT COUNT(email) FROM employees;
SELECT COUNT(DISTINCT department) FROM employees;
```

##### 🔵 SUM()

- Ignores NULL
- Works only on numeric types

```sql
SELECT SUM(salary) FROM employees;
```

##### 🔵 AVG()

- Ignores NULL values.

```sql
SELECT AVG(salary) FROM employees;

-- internally does
AVG = SUM / COUNT (non-null rows)
```

##### 🔵 MAX()/MIN()

- Numbers
- Dates
- Text (alphabetical order)

```sql
SELECT MAX(salary) FROM employees;
SELECT MIN(salary) FROM employees;
```

### 🟦 Boolean Aggregates

##### 🔵 BOOL_AND()

- Returns TRUE if all rows are true

```sql
SELECT BOOL_AND(is_active) FROM users;
```

##### 🔵 BOOL_OR()

- Returns TRUE if at least one row is true

```sql
SELECT BOOL_OR(is_admin) FROM users;
```

### 🟦 Array & JSON Aggregates (Very Powerful 🚀)

- These are extremely useful in modern backend systems.
- Since you work with APIs, this is very important.

##### 🔵 ARRAY_AGG()

- Combines rows into an array.

```sql
SELECT ARRAY_AGG(name) FROM employees;
```

- With GROUP BY:

```sql
SELECT department, ARRAY_AGG(name)
FROM employees
GROUP BY department;
```

##### 🔵 JSON_AGG()

- Returns JSON array
- Very useful for APIs.

```sql
SELECT JSON_AGG(employees) FROM employees;
```

##### 🔵 JSONB_AGG()

- Same but returns JSONB (better performance).

### 🟦 String Aggregation

##### 🔵 STRING_AGG()

- Concatenates text values.

```sql
SELECT STRING_AGG(name, ', ')
FROM employees;
```

- With ordering:

```sql
SELECT STRING_AGG(name, ', ' ORDER BY name)
FROM employees;
```

##### 🔵

```sql

```

##### 🔵

```sql

```

### 🟦 Bitwise Aggregates

- Less common but important in system-level logic.
- BIT_AND()
- BIT_OR()

### 🟦 XML Aggregates

- Used in XML-based systems.
- XMLAGG()

### 🟦 FILTER Clause (Advanced)

- You can filter inside aggregate
- Very powerful in reporting.

```sql
SELECT
    COUNT(*) FILTER (WHERE salary > 50000) AS high_salary,
    COUNT(*) FILTER (WHERE salary <= 50000) AS low_salary
FROM employees;
```

## ➡️ GROUP BY

- `GROUP BY` is used to combine rows having the same values in specified columns into groups.
- Then we usually apply aggregate functions on each group.
- `employees` table

| id  | name | department | salary |
| --- | ---- | ---------- | ------ |
| 1   | A    | IT         | 50000  |
| 2   | B    | HR         | 40000  |
| 3   | C    | IT         | 60000  |
| 4   | D    | HR         | 45000  |
| 5   | E    | IT         | 70000  |

### 🟦 Find total salary per department.

```sql
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department;
```

- What happens internally?
- **Step 1:** `FROM`
  - All rows loaded.
- **Step 2:** `GROUP BY` department
  - Rows are grouped like this:
  - IT group:
    - 50000
    - 60000
    - 70000
  - HR group:
    - 40000
    - 45000

- **Step 3:** `SELECT SUM(salary)`
  - Now aggregate function runs per group:

| department | total_salary |
| ---------- | ------------ |
| IT         | 180000       |
| HR         | 85000        |

### 🟦 Very Important Rule of GROUP BY 🔴

- If you use `GROUP BY`, every column in `SELECT` must either:
  - Be inside an aggregate function
  - `OR` Be included in `GROUP BY`

```sql
SELECT department, salary
FROM employees
GROUP BY department;
```

- Wrong Query, Because **salary** is neither aggregated nor grouped.

```sql
SELECT department, MAX(salary)
FROM employees
GROUP BY department;
```

- This is correct because **department** is included in the `Group By` and **salary** inside the Aggregate function `MAX()`

## ➡️ Having

- `HAVING` is used to filter groups after grouping happens.

### 🟦 WHERE vs HAVING

##### WHERE

- Filters rows
- Runs before GROUP BY
- Cannot use aggregate functions

##### HAVING

- Filters groups
- Runs after GROUP BY
- Can use aggregate functions

### 🟦 Show departments where total salary is greater than 100000.

```sql
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 100000;
```

```sql

```

### 🟦 Can We Use WHERE + GROUP BY + HAVING Together?

- YES, Show departments where:
  - Salary > 45000 (row filtering)
  - And total salary > 100000 (group filtering)

```sql
SELECT department, SUM(salary) AS total_salary
FROM employees
WHERE salary > 45000
GROUP BY department
HAVING SUM(salary) > 100000;

```

### 🟦 Find departments having more than 2 employees.

- Interview Important

```sql
SELECT department, COUNT(*) AS emp_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 2;
```

- Here two column **department** and **emp_count** (`COUNT(*)` provide the count).
