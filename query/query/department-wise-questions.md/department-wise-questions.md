⏺️ ➡️ 🟦 🔵🟢🔴⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

# ⏺️ Department Wise Questions

- employee table

```sql
| emp_name | department | salary |
| -------- | ---------- | ------ |
| A        | IT         | 100000 |
| B        | IT         | 100000 |
| C        | IT         | 90000  |
| D        | IT         | 90000  |
| E        | IT         | NULL   |
| F        | HR         | 95000  |
| G        | HR         | 95000  |
| H        | HR         | 85000  |
| I        | HR         | 85000  |
| J        | HR         | NULL   |

```

### ➡️ Department-wise Maximum Salary Query

- `MAX()` ignores `NULL`

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

##### 🟦 To get employee name also

```sql
SELECT emp_name, department, salary
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

```sql
| emp_name | department | salary |
| -------- | ---------- | ------ |
| A        | IT         | 100000 |
| B        | IT         | 100000 |
| F        | HR         | 95000  |
| G        | HR         | 95000  |
```

### ➡️ Department-wise Second Highest Salary Query

##### 🟦 Using DENSE_RANK()

- All the second highest salary

```sql
SELECT emp_name, department, salary
FROM (
    SELECT emp_name, department, salary,
           DENSE_RANK() OVER(
               PARTITION BY department
               ORDER BY salary DESC
           ) AS rnk
    FROM employee
) t
WHERE rnk = 2;
```

- Output

```sql
| emp_name | department | salary |
| -------- | ---------- | ------ |
| C        | IT         | 90000  |
| D        | IT         | 90000  |
| H        | HR         | 85000  |
| I        | HR         | 85000  |

```

##### 🟦 Using ROW_NUMBER()

- Only the distinct second highest row

```sql
SELECT emp_name, department, salary
FROM (
    SELECT emp_name, department, salary,
           ROW_NUMBER() OVER(
               PARTITION BY department
               ORDER BY salary DESC
           ) AS rn
    FROM employee
    WHERE salary IS NOT NULL
) t
WHERE rn = 2;
```

- Ouptut

```sql
| emp_name | department | salary |
| -------- | ---------- | ------ |
| B        | IT         | 100000 |
| G        | HR         | 95000  |

```

### ➡️ Count Employees Department-wise

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
| IT         | 4              |
| HR         | 4              |

```
