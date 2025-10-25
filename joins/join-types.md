🔵🟢🔴➡️⭕🟠🟦🟣🟥🟧✔️⏺️ ☑️ • ‣ → ⁕

# ⏺️ Join Types

## ➡️ INNER JOIN: Only Matching Rows from All Tables

- **What it does:** Returns only rows where there's a match in every table. Non-matches are completely excluded—like a strict group `photo` where everyone must show up.
- **When to use:** For complete records (**e.g.**, `photos` with `comments` from known `users`).
- Syntax (chaining multiple **INNER JOINs**):

```
    SELECT u.username AS uploader, p.caption AS photo, c.comment_text AS comment
    FROM users u
    INNER JOIN photos p ON u.id = p.user_id
    INNER JOIN comments c ON p.id = c.photo_id;
```

- Starts with users → matches photos (`u.id = p.user_id`) → matches comments (`p.id = c.photo_id`). Only Alice's photos with comments survive.

- **Result:**

```
| uploader | photo        | comment         |
| -------- | ------------ | --------------- |
| alice    | Beach sunset | Love this view! |
| alice    | Beach sunset | Great shot!     |
| alice    | City lights  | Urban vibes     |

```

- **Excluded:** **Bob** (no `photos`), **Carol's** `photo` (no `comments`).

## ➡️ LEFT JOIN: All from the "Left" Table(s), Matches from the Right

- **What it does:** Returns all rows from the leftmost table (users here), plus matching rows from the others. Non-matches get `NULL` in right-table columns — like inviting all users to a party, but only showing photo/comment details if they exist.
- **When to use:** To list all users/photos, even without comments (e.g., "All uploads, commented or not").

```
    SELECT u.username AS uploader, p.caption AS photo, c.comment_text AS comment
    FROM users u
    LEFT JOIN photos p ON u.id = p.user_id
    LEFT JOIN comments c ON p.id = c.photo_id;
```

- **How it works:** Prioritizes users → adds photos if match → adds comments if match. Bob and Carol's photo appear with `NULLs`.

- **Result:**

```
  | uploader | photo         | comment         |
| -------- | ------------- | --------------- |
| alice    | Beach sunset  | Love this view! |
| alice    | Beach sunset  | Great shot!     |
| alice    | City lights   | Urban vibes     |
| bob      | NULL          | NULL            |
| carol    | Mountain hike | NULL            |

```

- Multiple comments per photo create duplicate rows for that photo.

## ➡️ RIGHT JOIN: All from the "Right" Table(s), Matches from the Left

- **What it does:** Opposite of LEFT—returns all rows from the rightmost table (comments here), plus matching rows from the left. Non-matches get NULL in left-table columns—like focusing on every comment, even if the `photo/user` details are missing (rare, but useful for orphaned data).
- **When to use:** To ensure all comments are included, regardless of `photo/user` issues (e.g., auditing stray comments).
- **Syntax** (chain with RIGHT JOINs; order matters—comments as "right"):

```
    SELECT u.username AS uploader, p.caption AS photo, c.comment_text AS comment
    FROM users u
    RIGHT JOIN photos p ON u.id = p.user_id
    RIGHT JOIN comments c ON p.id = c.photo_id;
```

- **How it works:** Prioritizes comments → adds photos if match → adds users if match. All comments show; if there were a "orphan" comment (e.g., `photo_id=999`), it'd have `NULL` for `uploader/photo`.
- **Result** (Using our data—no orphans, so same as INNER but prioritized differently):

```
| uploader | photo        | comment         |
| -------- | ------------ | --------------- |
| alice    | Beach sunset | Love this view! |
| alice    | Beach sunset | Great shot!     |
| alice    | City lights  | Urban vibes     |

```

- If we added an orphan comment (photo_id=999, user_id=4):

```
| uploader | photo        | comment         |
| -------- | ------------ | --------------- |
| alice    | Beach sunset | Love this view! |
| alice    | Beach sunset | Great shot!     |
| alice    | City lights  | Urban vibes     |
| NULL     | NULL         | Orphan comment! |

```

- **Excluded:** Users without `photos/comments` (**Bob**, **Carol's** `photo`).

## ➡️ FULL OUTER JOIN: Everything from All Tables

- **What it does:** Returns all rows from every table. Matches combine; non-matches get NULL in the missing table's columns—like a massive reunion where everyone is listed, with blanks for no-shows.
- **When to use:** For a full audit (e.g., "All users, photos, and comments—spot the gaps!").

```
    SELECT u.username AS uploader, p.caption AS photo, c.comment_text AS comment
    FROM users u
    FULL OUTER JOIN photos p ON u.id = p.user_id
    FULL OUTER JOIN comments c ON p.id = c.photo_id;
```

- **How it works:** Combines all uniquely—users without `photos/comments` get `NULL` there; `photos` without `comments` get `NULL` for `comments`; `comments` without `photos/users` get `NULL` for those (though **FKs** prevent true orphans).

- **Result**

```
| uploader | photo         | comment         |
| -------- | ------------- | --------------- |
| alice    | Beach sunset  | Love this view! |
| alice    | Beach sunset  | Great shot!     |
| alice    | City lights   | Urban vibes     |
| bob      | NULL          | NULL            |
| carol    | Mountain hike | NULL            |

```

- If orphan comment added: Extra row with `NULL` | `NULL` | `Orphan comment`!
- **Note:** Results may vary in order; use `ORDER BY` for consistency.
