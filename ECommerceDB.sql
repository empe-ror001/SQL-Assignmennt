/* Question 1 : Explain the fundamental differences between DDL, DML, and DQL commands in SQL. 
Provide one example for each type of command.

Answer :- 	Here is a clear and simple explanation of the differences between 
			DDL, DML, and DQL in SQL, with examples.

✅ 1. DDL – Data Definition Language
Definition:

DDL commands are used to create, modify, and delete database structures (tables, schemas, indexes).
They define the structure of the database, not the data inside it.
Common DDL commands:
	● CREATE
	● ALTER
	● DROP
	● TRUNCATE

✔ Example (DDL):
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT
);

✅ 2. DML – Data Manipulation Language
Definition:

DML commands are used to insert, update, delete, and modify data inside tables.
They change the content of the database.

Common DML commands:
	● INSERT
	● UPDATE
	● DELETE

✔ Example (DML):
INSERT INTO Students (StudentID, Name, Age)
VALUES (1, 'John Doe', 20);

✅ 3. DQL – Data Query Language
Definition:

DQL commands are used to query or retrieve data from the database.
The main focus is reading data, not modifying it.

Common DQL command:
	● SELECT

✔ Example (DQL):
SELECT Name, Age
FROM Students;


Question 2 : What is the purpose of SQL constraints? 
Name and describe three common types of constraints, 
providing a simple scenario where each would be useful.

Answer :- 

✅ Purpose of SQL Constraints

SQL constraints are rules applied to table columns to ensure data accuracy, reliability, and integrity.
They prevent invalid or inconsistent data from being stored in a database.

✅ Three Common Types of SQL Constraints

1️ PRIMARY KEY Constraint
✔ Purpose
Uniquely identifies each row in a table
Cannot contain NULL values

✔ Scenario
In a Students table, every student must have a unique ID.
Two students cannot share the same StudentID.

✔ Example
StudentID INT PRIMARY KEY

2️. UNIQUE Constraint
✔ Purpose
Ensures all values in a column are unique
Unlike PRIMARY KEY, UNIQUE can contain one NULL

✔ Scenario
In a Users table, no two people should register with the same email address.

✔ Example
Email VARCHAR(100) UNIQUE

3️. FOREIGN KEY Constraint
✔ Purpose
Creates a relationship between two tables
Ensures the referenced value exists in another table
Maintains referential integrity

✔ Scenario
If you store orders, every order must correspond to a valid customer ID.

✔ Example
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)

Question 3 : Explain the difference between LIMIT and OFFSET clauses in SQL. 
How would you use them together to retrieve the third page of results, 
assuming each page has 10 records?
Answer :-

✅ Difference Between LIMIT and OFFSET in SQL
1️. LIMIT
Specifies how many rows to return.

Example:
LIMIT 10
→ Returns 10 rows.

2️. OFFSET
Specifies how many rows to skip before starting to return data.

Example:
OFFSET 20
→ Skip the first 20 rows, then start returning results.

✅ Using LIMIT and OFFSET Together
They are often used for pagination (displaying pages of records).

📌 Retrieve the 3rd page of results, with 10 records per page
➤ Formula for OFFSET:
OFFSET = (PageNumber - 1) × RecordsPerPage

For page 3:
OFFSET = (3 − 1) × 10 = 20

So, you skip 20 records and show the next 10.
✅ SQL Query for Page 3:
SELECT *
FROM YourTable
LIMIT 10
OFFSET 20;


Question 4 : What is a Common Table Expression (CTE) in SQL, 
and what are its main benefits? Provide a simple SQL example demonstrating its usage.
Answer :-

✅ What is a Common Table Expression (CTE)?
A CTE (Common Table Expression) is a temporary, named result set that you can reference within a single SQL query.

It is created using the WITH keyword.
A CTE behaves like a temporary table or subquery, but is easier to read and reuse.

✅ Main Benefits of a CTE
1️ Improves readability
	● Makes complex queries easier to understand.
	● Removes deeply nested subqueries.

2️. Reusability
	● You can reference the same CTE multiple times in a query.

3️. Useful for hierarchical or recursive queries
	● Example: employee → manager structures.

4️. Helps break down logic into smaller parts
	● Easier for debugging and step-by-step analysis.

✅ Simple SQL Example Using a CTE
Task: Show all employees earning more than 50,000 from a filtered list.
WITH HighSalaryEmployees AS (
    SELECT 
        employee_id,
        name,
        salary
    FROM 
        Employees
    WHERE 
        salary > 50000
)
SELECT 
    name,
    salary
FROM 
    HighSalaryEmployees
ORDER BY 
    salary DESC;

✔ Explanation
WITH HighSalaryEmployees AS (...)
	● Creates a temporary result named HighSalaryEmployees.

Second SELECT
	● Uses the CTE like a table.
	● Retrieves employees with salary > 50,000 and sorts them.


Question 5 : Describe the concept of SQL Normalization and its primary goals. 
Briefly explain the first three normal forms (1NF, 2NF, 3NF).
Answer :-

SQL Normalization is the process of organizing data in a database to reduce redundancy and 
improve data integrity. It involves dividing large tables into smaller, related tables and 
defining relationships between them.

Primary Goals:
	● Minimize Redundancy: To save storage space by ensuring data is not duplicated unnecessarily.

	● Prevent Data Anomalies: To avoid issues during data modification, such as Insertion 
	Anomalies (unable to add data without other missing data), Update Anomalies (needing 
	to update multiple rows for a single change), and Deletion Anomalies (unintentionally 
	losing data when deleting a row).

The First Three Normal Forms:
1. First Normal Form (1NF):
	● A table is in 1NF if all column values are atomic (indivisible). This means no repeating 
    groups or arrays are allowed in a single cell; every column must hold a single value, 
    and each row must be unique.

2. Second Normal Form (2NF):

	● A table is in 2NF if it is already in 1NF and contains no partial dependencies. This 
    means that if a table has a composite primary key (a key made of multiple columns), 
    all non-key attributes must depend on the entire primary key, not just a part of it.

3. Third Normal Form (3NF):

	● A table is in 3NF if it is already in 2NF and contains no transitive dependencies. This
    means that non-key attributes must depend only on the primary key and not on other 
    non-key attributes (e.g., if A determines B, and B determines C, then C is transitively
    dependent on A, which violates 3NF).

 */

-- Question 6 : Create a database named ECommerceDB and perform the following tasks:

-- 1. Create database ECommerceDB
create database if not exists ECommerceDB;

-- Use database ecommercedb
use ecommercedb;

-- 2. Create Tables with Constraints
-- a. Categories Table
create table Categories(
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50) NOT NULL UNIQUE
);

-- b. Product Table
create table Products(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100) NOT NULL UNIQUE,
CategoryID INT ,
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
Price DECIMAL(10,2) NOT NULL,
StockQuantity INT
);

-- c. Customers Table
create table Customers(
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(100) NOT NULL ,
Email VARCHAR(100) UNIQUE,
JoinDate DATE
);

-- d. Orders Table
create table Orders(
OrdersID INT PRIMARY KEY,
CustomerID INT,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
OrderDate DATE NOT NULL,
TotalAmount DECIMAL(10,2)
);

-- 3. Insert Data
-- a. Inserting data Categories
insert into Categories (CategoryID, CategoryName) values
(1, 'Electronics'),
(2, 'Books'),
(3, 'Home Goods'),
(4, 'Apparel');

-- b. Inserting data Products
insert into Products (ProductID, ProductName, CategoryID, Price, StockQuantity) values
(101, 'Laptop Pro', 1, 1200.00, 50),
(102, 'SQL Handbook', 2, 45.50, 200),
(103, 'Smart Speaker', 1, 99.99, 150),
(104, 'Coffee Maker', 3, 75.00, 80),
(105, 'Novel: The Great SQL', 2, 25.00, 120),
(106, 'Wireless Earbuds', 1, 150.00, 100),
(107, 'Blender X', 3, 120.00, 60),
(108, 'T-Shirt Casual', 4, 20.00, 300);

-- c. Inserting data Customers
insert into Customers (CustomerID, CustomerName, Email, JoinDate) values
(1, 'Alice Wonderland', 'alice@example.com', '2023-01-10'),
(2, 'Bob the Builder', 'bob@example.com', '2022-11-25'),
(3, 'Charlie Chaplin', 'charlie@example.com', '2023-03-01'),
(4, 'Diana Prince', 'diana@example.com', '2021-04-26');


-- d. Inserting data Oders
insert into Orders (OrdersID, CustomerID, OrderDate, TotalAmount) values
(1001, 1, '2023-04-26', 1245.50),
(1002, 2, '2023-10-12', 99.99),
(1003, 1, '2023-07-01', 145.00),
(1004, 3, '2023-01-14', 150.00),
(1005, 2, '2023-09-24', 120.00),
(1006, 1, '2023-06-19', 20.00);

/* Question 7 : Generate a report showing CustomerName, Email, 
and the TotalNumberofOrders for each customer. 
Include customers who have not placed any orders, 
in which case their TotalNumberofOrders should be 0. 
Order the results by CustomerName. */

-- Customer Report (Include 0 orders).
select c.CustomerName, c.Email, count(o.OrdersID) as TotalNumberofOrders
from Customers c 
left join Orders o on o.CustomerID  = o.CustomerID
group by c.CustomerID, c.CustomerName, c.Email
order by c.CustomerName;


/*Question 8 : Retrieve Product Information with Category: 
Write a SQL query to display the ProductName, Price, StockQuantity, and CategoryName for all products. 
Order the results by CategoryName and then ProductName alphabetically.*/ 

-- Product Info with Category.
select 
	p.ProductName, 
	p.Price, 
	p.StockQuantity, 
	cat.CategoryName
from Products p
join Categories cat on p.CategoryID = p.CategoryID
order by cat.CategoryName asc, p.ProductName asc;


/* Question 9 : Write a SQL query that uses a Common Table Expression (CTE) 
and a Window Function (specifically ROW_NUMBER() or RANK()) to display the CategoryName, 
ProductName, and Price for the top 2 most expensive products in each CategoryName. */

-- Top 2 Expensive Products per Category (Using CTE & Window Function)
WITH RankedProducts AS (
    SELECT 
        cat.CategoryName,
        p.ProductName,
        p.Price,
        DENSE_RANK() OVER (PARTITION BY cat.CategoryName ORDER BY p.Price DESC) as RankNum
    FROM Products p
    JOIN Categories cat ON p.CategoryID = cat.CategoryID
)
SELECT CategoryName, ProductName, Price
FROM RankedProducts
WHERE RankNum <= 2;

/* uestion 10 : You are hired as a data analyst by Sakila Video Rentals, a global movie rental company. 
The management team is looking to improve decision-making by analyzing existing customer, rental, and inventory data.
Using the Sakila database, answer the following business questions to support key strategic initiatives.
Tasks & Questions: */

-- Use sakila
use sakila;

/* 10.1 - Identify the top 5 customers based on the total amount they’ve spent. 
Include customer name, email, and total amount spent.*/
SELECT 
    c.first_name, 
    c.last_name, 
    c.email, 
    SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;

/* 10.2 - Which 3 movie categories have the highest rental counts? 
Display the category name and number of times movies 
from that category were rented. */

SELECT c.name AS category_name, COUNT(r.rental_id) AS rental_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY rental_count DESC
LIMIT 3;

/* 10.3 - Calculate how many films are available at each store and 
how many of those have never been rented. */

SELECT 
    i.store_id,
    COUNT(i.inventory_id) as total_inventory,
    SUM(CASE WHEN r.rental_id IS NULL THEN 1 ELSE 0 END) as never_rented
FROM inventory i
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY i.store_id;


-- 10.4 - Show the total revenue per month for the year 2023 to analyze business seasonality.
SELECT 
    MONTHNAME(payment_date) as Month, 
    SUM(amount) as Revenue
FROM payment
WHERE YEAR(payment_date) = 2023
GROUP BY MONTH(payment_date), MONTHNAME(payment_date)
ORDER BY MONTH(payment_date);

-- 10.5 - Identify customers who have rented more than 10 times in the last 6 months.
SELECT c.first_name, c.last_name, COUNT(r.rental_id) as rental_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE r.rental_date >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
GROUP BY c.customer_id
HAVING rental_count > 10;



