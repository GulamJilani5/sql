🔵🟢🔴➡️⭕🟠🟦🟣🟥🟧✔️⏺️ ☑️ • ‣ → ⁕

# ⏺️ Joins

Joins don't just magically combine tables—they rely on keys to decide what to match. In relational databases like PostgreSQL, we use Primary Keys (PK) and Foreign Keys (FK) to create these links. Think of them as "IDs" that keep your data organized and connected, like a passport number linking your ID to your travel records.

## ➡️ Table Structures and Relationships

- **users table:** Stores user info. **PK:** `id` (unique user ID).
- **photos table:** Stores photos uploaded by users. **PK:** `id` (unique photo **ID**). **FK:** `user_id` (references `users.id` — tells us who uploaded the photo).
- **comments table:** Stores comments on photos. **PK:** id (unique comment ID). **FK:** `photo_id` (references `photos.id` — what photo it's on). **FK:** `user_id` (references `users.id` — who left the comment).

## ➡️ Primary Key (PK): The Unique ID for Each Row

A special column (or combo of columns) in a table that gives every single row its own unique fingerprint. No two rows can have the same value here—duplicates are banned! It's like a social security number or username that ensures "this row is this exact `user/photo/comment`.

### 🟦 users table (PK: id):

| id (PK) | username | email                                     |
| ------- | -------- | ----------------------------------------- |
| 1       | alice    | [alice@email.com](mailto:alice@email.com) |
| 2       | bob      | [bob@email.com](mailto:bob@email.com)     |
| 3       | carol    | [carol@email.com](mailto:carol@email.com) |

- Here, **id** is the **PK**, no duplicates, auto-assigned when inserting a new user.

## ➡️ Foreign Key (FK): The "Pointer" to Another Table's PK

A column in one table that holds values from another table's PK. It acts like a hyperlink, saying "this row connects to that row over there." It enforces rules: The **FK** value must match an existing **PK** in the referenced table (or be `NULL`, if allowed).

### 🟦 photos table (PK: id):

| id (PK) | user_id (FK → users.id) | caption       | upload_date |
| ------- | ----------------------- | ------------- | ----------- |
| 101     | 1                       | Beach sunset  | 2025-10-01  |
| 102     | 1                       | City lights   | 2025-10-02  |
| 103     | 3                       | Mountain hike | 2025-10-03  |

- Each photo gets its own **id** **PK**, regardless of who uploaded it.
- **FK:** `user_id` → references `users.id` **PK**
- `user_id` **FK** ensures every photo links to a real user. Can't upload for `"user_id=99"` if no such user exists.

### 🟦 comments table (PK: id):

| id (PK) | photo_id (FK → photos.id) | user_id (FK → users.id) | comment_text    | comment_date     |
| ------- | ------------------------- | ----------------------- | --------------- | ---------------- |
| 201     | 101                       | 2                       | Love this view! | 2025-10-01 12:00 |
| 202     | 101                       | 3                       | Great shot!     | 2025-10-01 13:00 |
| 203     | 102                       | 3                       | Urban vibes     | 2025-10-02 10:00 |

- Every comment is uniquely tagged with its own **id**.
- `photo_id` **FK** → references `photos.id` **PK** (which photo?).
- `user_id` **FK** → references `users.id` **PK** (who commented?).

➡️ How PK + FK Power Joins (Quick Tie-Back)

- Remember in JOIN queries? They rely on these:
  - `ON users.id = photos.user_id` (PK = FK).
  - `ON photos.id = comments.photo_id` (PK = FK).
