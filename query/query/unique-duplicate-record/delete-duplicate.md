⏺️ ➡️ 🟦 🔵 🟢 🔴 ⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

# ⏺️ Remove Duplicate Records

```sql
| id | name  | email       |
| -- | ----- | ----------- |
| 1  | Alice | a@gmail.com |
| 2  | Bob   | b@gmail.com |
| 3  | Carol | c@gmail.com |
| 4  | Alice | a@gmail.com |
| 5  | David | d@gmail.com |
| 6  | Carol | c@gmail.com |
| 7  | Carol | c@gmail.com |

```

### ➡️ removing duplicated(extra) rows (Get Only Distinct email values)

- If Email occurs 3 times then delete other 2 and keep only once.

##### 🟦 Deleting using `USING` is only in the Postgresql

```sql
DELETE FROM employees e1
USING employees e2
WHERE e1.id > e2.id
AND e1.email = e2.email;
```

```sql
| id | name  | email       |
|----|-------|-------------|
| 1  | Alice | a@gmail.com |
| 2  | Bob   | b@gmail.com |
| 3  | Carol | c@gmail.com |
| 5  | David | d@gmail.com |
```

##### 🟦 Delete Using EXISTS Operator

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

```sql
| id | name  | email       |
|----|-------|-------------|
| 1  | Alice | a@gmail.com |
| 2  | Bob   | b@gmail.com |
| 3  | Carol | c@gmail.com |
| 5  | David | d@gmail.com |
```

#### 🟦 Using CTE + ROW_NUMBER()

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

```sql

| id | name  | email       |
|----|-------|-------------|
| 1  | Alice | a@gmail.com |
| 2  | Bob   | b@gmail.com |
| 3  | Carol | c@gmail.com |
| 5  | David | d@gmail.com |
```

### ➡️ Delete all rows which are duplicates(Get only unique records)

```sql
DELETE FROM employee emp1
USING (
    SELECT email
    FROM employee
    GROUP BY email
    HAVING COUNT(*) > 1
) emp2
WHERE emp1.email = emp2.email;
```

```sql
| id | name  | email       |
|----|-------|-------------|
| 2  | Bob   | b@gmail.com |
| 5  | David | d@gmail.com |
```
