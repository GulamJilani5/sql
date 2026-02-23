⏺️ ➡️ 🟦 🔵🟢🔴⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

# ⏺️ subquery

## ➡️ Based on Execution

### 🟦 Non-Correlated Subquery

- Run once

### 🟦 Correlated Subquery

- Run Once per outer row

## ➡️ Based on Position

### 🟦 Subquery in WHERE

- Most common type.
- It can be Correlated
- Used for:
  - Filtering
  - Comparison
  - `EXISTS` checks
  - `IN` checks
- Important Operators Used in **WHERE** Subqueries
  - `=`
  - `>`
  - `<`
  - `IN`
  - `NOT IN`
  - `EXISTS`
  - `ANY`
  - `ALL`

##### Single Value Subquery

```sql
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
```

- **Execution:**
  - Inner query runs first → returns one value (average salary)
  - Outer query compares salary with that value
  - Returns employees earning above average.

##### Multi-row Subquery (IN)

```sql
SELECT *
FROM employees
WHERE department_id IN (
    SELECT id
    FROM departments
    WHERE location = 'Pune'
);
```

- **Execution:**
  - Subquery returns multiple department IDs(**List of IDs**)
  - Outer query matches with the list using `IN`

##### EXISTS

```sql
SELECT *
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e.department_id = e2.department_id
    AND e2.salary > 100000
);
```

- Checks if at least one matching record exists.

#### 🟦 Subquery in FROM (Derived Table)

- subquery behaves like a temporary table.
- Subquery in `FROM` must have an alias like `AS dept_avg` in below example.
- Usually it is not correlated.

```sql
SELECT dept_id, avg_salary
FROM (
    SELECT department_id AS dept_id,
           AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_avg
WHERE avg_salary > 50000;
```

- **Execution:**
  - Inner query executes first
  - Result becomes a temporary table (`dept_avg`)
  - Outer query runs on that result

#### 🟦 Subquery in SELECT

- Used to fetch calculated values per row.
- - It can be Correlated

```sql
SELECT
    name,
    salary,
    (
        SELECT AVG(salary)
        FROM employees
    ) AS avg_salary
FROM employees;
```

- This adds an extra column to each row.
