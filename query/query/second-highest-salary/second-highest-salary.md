⏺️ ➡️ 🟦 🔵🟢🔴⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

# ⏺️ finding the second highest salary value of the given table in the sql query using postgresql.

### ➡️ Way 1

- ORDER BY + OFFSET + LIMIT (most common & clean)

```sql
SELECT DISTINCT salary
FROM employee
ORDER BY salary DESC
OFFSET 1
LIMIT 1;

```

##### 🟦 Fetch employee details with 2nd highest salary

- Usually we don't only get salart but entire details

```sql
SELECT *
FROM Employee
WHERE salary = (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    OFFSET 1 LIMIT 1
);
```

### ➡️ Way 2:

- Subquery with MAX

- But since `MAX()` only cares about the largest value, duplicates don’t change the result.

```sql
SELECT MAX(salary) AS second_highest_salary
FROM employee
WHERE salary < (
    SELECT MAX(salary)
    FROM employee
);

```

### ➡️ Way 3

- Using **DENSE_RANK()**

```sql
SELECT salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employee
) t
WHERE rnk = 2;
```

##### 🟦 Nth highest salary

- Replace N = 2 for second highest

```sql
SELECT salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employee
) t
WHERE rnk = N;
```
