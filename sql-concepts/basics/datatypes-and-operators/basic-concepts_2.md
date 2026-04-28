⏺️ ➡️ 🟦 🔵🟢🔴⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

# ⏺️ Operator In SQL

### ➡️ Comparison Operators

- Used in `WHERE` conditions.

| Operator     | Meaning          |
| ------------ | ---------------- |
| `=`          | Equal            |
| `<>` or `!=` | Not equal        |
| `>`          | Greater than     |
| `<`          | Less than        |
| `>=`         | Greater or equal |
| `<=`         | Less or equal    |

```sql
SELECT * FROM users
WHERE salary >= 50000;
```

### ➡️ Logical Operators

- Used to combine conditions.
  | Operator | Meaning |
  | -------- | ---------------------------- |
  | `AND` | Both conditions must be true |
  | `OR` | At least one condition true |
  | `NOT` | Negates condition |

```sql
SELECT *
FROM users
WHERE department = 'IT'
AND salary > 60000;
```

### ➡️ NULL Checking

| Operator      | Meaning       |
| ------------- | ------------- |
| `IS NULL`     | Value is NULL |
| `IS NOT NULL` | Not NULL      |

```sql
SELECT *
FROM users
WHERE email IS NULL;
```

- Never use `= NULL` (wrong).

### ➡️ Membership Operators

| Operator | Meaning                 |
| -------- | ----------------------- |
| `IN`     | Match in list           |
| `NOT IN` | Not in list             |
| `EXISTS` | Subquery returns row    |
| `ANY`    | Compare with any value  |
| `ALL`    | Compare with all values |

### ➡️ Pattern Matching Operators

##### 🟦 LIKE

```sql
SELECT * FROM users
WHERE name LIKE 'A%';
```

- Wildcards:
  - `%` → any characters
  - `_` → single character

##### 🟦 ILIKE (PostgreSQL specific)

```sql
SELECT * FROM users
WHERE name ILIKE 'a%';
```

##### 🟦 SIMILAR TO

- Advanced pattern matching (regex-like).

```sql
SELECT * FROM users
WHERE name SIMILAR TO '(A|B)%';
```

### ➡️ Range Operators

- `BETWEEEN`

```sql
SELECT *
FROM users
WHERE salary BETWEEN 40000 AND 80000;
```

- equivalent to:

```sql
salary >= 40000 AND salary <= 80000
```

### ➡️ Arithmetic Operators

| Operator | Meaning        |
| -------- | -------------- |
| `+`      | Addition       |
| `-`      | Subtraction    |
| `*`      | Multiplication |
| `/`      | Division       |
| `%`      | Modulus        |

### ➡️ String Operators

- Concatenation

```sql
SELECT first_name || ' ' || last_name AS full_name
FROM users;
```

### ➡️ JSON Operators

- Since PostgreSQL supports JSON, these are important.

  | Operator | Meaning         |
  | -------- | --------------- |
  | `->`     | Get JSON object |
  | `->>`    | Get JSON text   |
  | `#>`     | Get nested JSON |
  | `@>`     | Contains        |

```sql
SELECT data->>'name'
FROM users;
```

### ➡️ Array Operators

- PostgreSQL supports arrays.

| Operator | Meaning         |
| -------- | --------------- |
| `@>`     | Contains        |
| `<@`     | Is contained by |
| `&&`     | Overlap         |

```sql
SELECT *
FROM users
WHERE roles @> ARRAY['admin'];
```

### ➡️ Special PostgreSQL Operators

- DISTINCT FROM
  - Better NULL comparison.

```sql
SELECT *
FROM users
WHERE salary IS DISTINCT FROM NULL;
```

- Unlike `<>`, this handles `NULL` safely.

### ➡️ Bitwise Operators

- Used in low-level systems.

| Operator | Meaning     |     |
| -------- | ----------- | --- |
| `&`      | AND         |     |
| `        | `           | OR  |
| `#`      | XOR         |     |
| `~`      | NOT         |     |
| `<<`     | Left shift  |     |
| `>>`     | Right shift |     |
