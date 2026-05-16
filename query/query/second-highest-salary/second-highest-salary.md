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

##### 🟦 NULL handling of salary

```sql
SELECT DISTINCT salary AS second_highest_salary
FROM employee
WHERE salary IS NOT NULL
ORDER BY salary DESC
OFFSET 1
LIMIT 1;
```

##### 🟦 Fetch employee details with 2nd highest salary

- Usually we don't only get salary but entire details(full row)

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

##### 🟦 We don't care about whether salary is NULL or not NULL.

```sql
SELECT MAX(salary) AS second_highest_salary
FROM employee
WHERE salary < (
    SELECT MAX(salary)
    FROM employee
);
```

##### 🟦 NULL handling of salary

```sql
SELECT MAX(salary) AS second_highest_salary
FROM employee
WHERE salary IS NOT NULL
WHERE salary < (
    SELECT MAX(salary)
    FROM employee
    WHERE salary IS NOT NULL
);
```

### ➡️ Way 3

- Using **DENSE_RANK()**
- Outer Select will used the fileds which was returned by the internal query
-

##### 🟦 We are asssuming salary is not null

- Selecting only salary fields

```sql
SELECT salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employee
) t
WHERE rnk = 2;
```

##### 🟦 If salary is null then how to handle it

- selecting `empid`, `name`, `salary`

```sql
SELECT salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employee
    WHERE salary IS NOT NULL
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
