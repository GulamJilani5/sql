⏺️ ➡️ 🟦 🔵🟢🔴⭕🟠🟣🟥🟧✔️ ☑️ • ‣ → ⁕

# ⏺️ What are Indexes in databases? Types (clustered vs non-clustered)

- Find `D:\Jilani\learning\system design\typeofsystems\databasepattern\indexing.md`

- An index is a data structure that helps find rows quickly without scanning the entire table.

### 🟦 Advantages:

- Speeds up queries using filters, joins, or sorting.
- Improves read performance.

### 🟦 Disadvantages:

- Slows down write operations (insert, update, delete).

# ⏺️ What is partitioning

- Find `D:\Jilani\learning\system design\typeofsystems\databasepattern\partitioning.md`

- Boosts performance by dividing a database into smaller, logical pieces (“partitions”).
- Data is split within the system, with all partitions typically residing on the same server.
- Partitions can be based on specific rules (e.g., user ID, date).

### ➡️ Partitioning vs Sharding

| Aspect            | Partitioning                       | Sharding                              |
| ----------------- | ---------------------------------- | ------------------------------------- |
| **Data Location** | All partitions exist on one server | Each shard lives on a separate server |
| **Main Focus**    | Organizing the data                | Scaling across multiple machines      |
| **Data Split**    | Splitting data within a system     | Splitting data across systems         |

# ⏺️ Replication

- Find `D:\Jilani\learning\system design\typeofsystems\databasepattern\replication.md`

- Copying database data to multiple servers (“replicas”).
- Improves read performance and availability.
- Supports fault tolerance (backups).
- Replicas can contain either full or partial copies of the data
