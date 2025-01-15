
# Inventory Management System

## Overview
This project is a comprehensive **Inventory Management System** designed to streamline inventory tracking, sales reporting, and transaction management. The system was developed as part of the **DAMG 6210 Data Management and Database Design** course. It includes the creation of a robust database, an **Entity-Relationship (ER) Diagram**, and several views and procedures to manage key aspects of inventory, customers, suppliers, and sales.

---

## Features and Components

### **Database Design**
- **Entity-Relationship Diagram (ERD)**: A detailed ERD was created to represent the relationships among entities such as Customers, Suppliers, Products, Transactions, and Stock.
- **Normalization**: Ensured database normalization to reduce redundancy and improve efficiency.
- **Table Design**: Tables were designed with appropriate fields to store relevant data, ensuring scalability and integrity.

### **Views**
- **ADMIN_VIEW**: Provides an overview of administrative activities and permissions.
- **Customer Information**: A detailed view of customer profiles and contact details.
- **Customer Transaction History**: Summarizes individual customer transactions.
- **Product Sale View**: Displays all products sold within a specific timeframe.
- **Stock View**: Tracks available stock for all products in the inventory.
- **Supplier View**: Lists supplier details and transactions.
- **Return Sale View and Return Transaction View**: Tracks returns by customers.
- **Reports**:
  - **Daily Sales Report**: Displays daily sales totals.
  - **Monthly Sales Report**: Summarizes monthly sales data.
  - **Top Selling Product Report**: Identifies the most popular products.

### **Procedures and Packages**
- **Procedures**:
  - Customer onboarding and transaction management.
  - Supplier onboarding and stock purchasing.
  - Update and delete procedures for entities like customers, suppliers, stock, and admins.
- **Packages**:
  - Consolidated packages for handling customer and admin operations, ensuring modularity and reusability.

### **Security and User Management**
- User roles such as **Super Admin**, **Junior Admin**, and **Inventory Manager** were defined.
- User accounts were created with specific permissions on tables and views to enforce data security and access control.
- Granting and revoking permissions as needed for effective user role management.

---

## Workflow

1. **Database Creation**:
   - Tables were created using SQL scripts (e.g., `PLSQL DDL.sql`).
   - Data was inserted using scripts (`CREATE USER IN ADMIN.sql`, `PACKAGES.sql`).

2. **Feature Implementation**:
   - Designed views to simplify data access and reporting.
   - Developed PL/SQL procedures to handle business logic (e.g., customer onboarding, stock updates).

3. **Data Flow and Rules**:
   - Data flow diagrams created for customer and supplier transactions.
   - Business rules implemented for data validation and consistency.

4. **Reporting**:
   - Generated daily, monthly, and product-specific sales reports.
   - Analyzed inventory trends and transaction patterns.

---

## Insights
1. **Sales Trends**:
   - Daily and monthly sales reports highlight peak periods and popular products.
2. **Inventory Analysis**:
   - Stock view helps identify low-stock items for timely replenishment.
3. **Customer Behavior**:
   - Customer transaction history provides insights into buying patterns.
4. **Supplier Performance**:
   - Supplier view tracks supplier contributions and transaction details.

---

## Tools and Technologies
- **Database**: Oracle PL/SQL
- **Tools**: SQL Developer, ERD modeling tools
- **Languages**: SQL, PL/SQL
- **Reports**: Generated using database views and queries.

---

## Conclusion
The **Inventory Management System** effectively demonstrates database management principles, including ERD design, SQL scripting, user role management, and data security. This system is scalable and can be further extended with additional features, such as real-time inventory tracking or integration with external systems.

