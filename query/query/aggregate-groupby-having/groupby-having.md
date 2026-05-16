⏺️ ➡️ 🟦 🔵🟢🔴⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

# ⏺️ Group By & Having

### ➡️ GROUP BY

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

##### 🟦 Find total salary per department.

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

##### 🟦 Very Important Rule of GROUP BY 🔴

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

### ➡️ Having

- `HAVING` is used to filter groups after grouping happens.

##### 🟦 WHERE vs HAVING

- WHERE
  - Filters rows
  - Runs before GROUP BY
  - Cannot use aggregate functions

- HAVING
  - Filters groups
  - Runs after GROUP BY
  - Can use aggregate functions

##### 🟦 Show departments where total salary is greater than 100000.

```sql
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 100000;
```

```sql

```

##### 🟦 Can We Use WHERE + GROUP BY + HAVING Together?

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

##### 🟦 Find departments having more than 2 employees.

- Interview Important

```sql
SELECT department, COUNT(*) AS emp_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 2;
```

- Here two column **department** and **emp_count** (`COUNT(*)` provide the count).

### ➡️ Some Important Questions

- employee table

```sql
| emp_name | department | salary |
| -------- | ---------- | ------ |
| Ali      | IT         | 70000  |
| Ahmed    | IT         | 90000  |
| Sara     | HR         | 60000  |
| John     | HR         | 75000  |
```

##### 🟦 Department-wise Maximum Salary Query

```sql
SELECT department,
       MAX(salary) AS max_salary
FROM employee
GROUP BY department;
```

- Output

```sql
| department | max_salary |
| ---------- | ---------- |
| IT         | 90000      |
| HR         | 75000      |

```

- To get employee name also

```sql
SELECT emp_name,
       department,
       salary
FROM (
    SELECT emp_name,
           department,
           salary,
           DENSE_RANK() OVER(
               PARTITION BY department
               ORDER BY salary DESC
           ) AS rnk
    FROM employee
) t
WHERE rnk = 1;
```

##### 🟦 Count Employees Department-wise

```sql
SELECT department,
       COUNT(*) AS employee_count
FROM employee
GROUP BY department;
```

- Output

```sql
| department | employee_count |
| ---------- | -------------- |
| IT         | 5              |
| HR         | 3              |

```
