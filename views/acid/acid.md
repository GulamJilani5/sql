# ACID

It’s a set of properties that ensure reliable and predictable database transactions

### 1. Atomicity

Atomicity ensures that a transaction is treated as a single, indivisible unit. Either all operations in the transaction are completed successfully, or none of them are applied. If any part fails, the entire transaction is rolled back to its original state.

**Use Case:**
**Bank Transfer:** When transferring $100 from Account A to Account B, atomicity ensures that both the debit from A and the credit to B happen together. If the system crashes after debiting A but before crediting B, atomicity rolls back the debit to prevent money from disappearing.
**Online Order Placement:** When a customer places an order, the system updates the inventory, processes payment, and records the order. Atomicity ensures all these steps complete successfully or none do, avoiding scenarios like charging a customer without recording the order.

### 2. Consistency

Consistency ensures that a transaction brings the database from one valid state to another, maintaining all predefined rules, constraints, and data integrity. After a transaction, the database must comply with all its rules (e.g., unique keys, foreign key constraints, or data type rules).

**Use Case:**
**Bank Account Balance:** A database rule might require that account balances never go negative. If a withdrawal transaction tries to deduct more money than is available, consistency ensures the transaction is rejected to maintain the rule.
**Inventory Management:** In an e-commerce system, consistency ensures that the number of items in stock is never negative. If two customers try to buy the last item simultaneously, the system ensures only one transaction succeeds, keeping inventory data valid.

### 3. Isolation

Isolation ensures that transactions are executed independently of one another. Partial changes from one transaction are not visible to others until the transaction is complete. This prevents interference between concurrent transactions.

**Use Case:**
**Concurrent Banking Transactions:** If two users simultaneously transfer money from the same account, isolation ensures that one transaction completes before the other begins (or uses mechanisms like locking) to prevent double-spending or incorrect balance updates.
**Flight Booking System:** When multiple users try to book the last seat on a flight, isolation ensures that each booking transaction is processed independently, preventing two users from booking the same seat.

### 4. Durability

Durability guarantees that once a transaction is committed, its changes are permanently saved, even in the event of a system failure (e.g., power outage or crash). This is typically achieved through mechanisms like transaction logs or write-ahead logging.

**Use Case**:  
**E-commerce Purchase:** After a customer completes a purchase, durability ensures that the order details are saved permanently, even if the server crashes immediately after. The customer won’t lose their order, and the system can recover the data.
**Audit Logging:** In a financial system, durability ensures that audit logs of transactions (e.g., stock trades) are permanently recorded, so they can be retrieved even after a hardware failure.
