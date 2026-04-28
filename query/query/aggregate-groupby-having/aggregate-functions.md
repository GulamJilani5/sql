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
