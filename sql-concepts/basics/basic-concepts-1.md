⏺️ ➡️ 🟦 🔵🟢🔴⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

# ⏺️ Data Types in Postgresql

### ➡️ Numeric Types

- `SMALLINT`
- `INT / INTEGER`
- `BIGINT`
- `SERIAL`
- `BIGSERIAL`
- `NUMERIC(p,s) / DECIMAL(p,s)`
- `REAL`
- `DOUBLE PRECISION`

```sql

```

### ➡️ Character / String Types

- `CHAR(n)`
- `VARCHAR(n)`
- `TEXT`

```sql

```

### ➡️ Boolean Type

`BOOLEAN`

```sql

```

### ➡️ Date & Time Types

- `DATE`
- `TIME`
- `TIMESTAMP`
- `TIMESTAMP WITH TIME ZONE (timestamptz)`
- `INTERVAL`

```sql

```

### ➡️ UUID Type

- `UUID`

```sql

```

### ➡️ Binary Data

- `BYTEA`

```sql

```

### ➡️ JSON Types

- `JSON`
- `JSONB`

```sql

```

### ➡️ Network Address Types

- `INET`
- `CIDR`
- `MACADDR`

```sql

```

### ➡️ Arrays

- `INTEGER[]`
- `TEXT[]`
- `VARCHAR[]`

```sql

```

### ➡️ Special / Advanced Types

- `ENUM (custom type)`
- `HSTORE (key-value)`
- `XML`
- `TSVECTOR (full text search)`

```sql

```

# ⏺️ Creating Table, Inserting Values, DELETE, TRUNCATE, DROP

### ➡️ Creating Table

- In my pg admin I am having already exist `users` table so I am creating table name as `users_new`

```sql
CREATE TABLE users_new (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50),
    dob DATE
);
```

### ➡️ Inserting Values

```sql
INSERT INTO users_new (id, username, dob)
VALUES (1, 'Ali', '2000-05-10');
```

```sql
INSERT INTO users_new (username, dob)
VALUES
('Ali', '2000-05-10'),
('Sara', '1999-12-25'),
('John', '2001-08-15');
```

### ➡️ DELETE

- Removes rows (data) from a table
- Table structure remains
- Can be rolled back (if inside transaction)

```sql
DELETE FROM users_new WHERE id = 5;
```

```sql
DELETE FROM users_new WHERE id = 5;
```

- Delete all rows:

```sql
DELETE FROM users_new;
```

### ➡️ TRUNCATE

- Removes all rows from the table (fast)
- Table structure remains
- Faster than DELETE because it doesn’t scan row by row
- Can be rolled back (in PostgreSQL, inside transaction)

```sql

```

### ➡️ DROP

- Removes the entire table
- Deletes both data + schema (table structure)
- Table no longer exists

```sql
DROP TABLE users;

```

### ➡️

```sql

```

### ➡️

```sql

```

### ➡️

```sql

```
