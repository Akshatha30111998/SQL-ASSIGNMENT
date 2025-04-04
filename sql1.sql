1./* Create a table called employees with the following structure?
: emp_id (integer, should not be NULL and should be a primary key)Q
: emp_name (text, should not be NULL)Q
: age (integer, should have a check constraint to ensure the age is at least 18)Q
: email (text, should be unique for each employee)Q
: salary (decimal, with a default value of 30,000).

Write the SQL query to create the above table with all constraints.*/


DROP TABLE employees;
CREATE TABLE employees (
  emp_id INTEGER PRIMARY KEY NOT NULL,
  emp_name TEXT NOT NULL,
  age INTEGER CHECK(age >= 18),
  email VARCHAR(255) UNIQUE,
  salary DECIMAL(10, 2) DEFAULT 30000.00
);
SHOW COLUMNS FROM employees;
/*2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
examples of common types of constraints.

2.Constraints in a database are rules that ensure data integrity and consistency by limiting the type of data that can be inserted, updated, or deleted. They help maintain data accuracy, prevent errors, and support data relationships.

Types of Constraints:
1. Primary Key (PK) Constraint: Uniquely identifies each record in a table. Ensures that no duplicate values exist.
2. Foreign Key (FK) Constraint: Establishes relationships between tables. Ensures that values in one table match existing values in another table.
3. Unique Constraint: Ensures that all values in a column are unique.
4. Not Null Constraint: Ensures that a column cannot contain null values.
5. Check Constraint: Ensures that data in a column meets specific conditions.
6. Default Constraint: Assigns a default value to a column when no value is provided.


Constraints:

- Primary Key (PK) on emp_id ensures unique employee IDs.
- Foreign Key (FK) on dept_id ensures that employees are assigned to existing departments.
- Unique Constraint on email ensures that each email address is unique.
- Not Null Constraint on emp_name ensures that employee names are always provided.
- Check Constraint on age ensures that employees are at least 18 years old.
- Default Constraint on salary assigns a default value if not provided.*/

/*3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
your answer.
Applying NOT NULL Constraint:
The NOT NULL constraint is applied to a column to ensure that it cannot contain null values. This is useful for several reasons:

1. Data Integrity: By preventing null values, you ensure that the data in the column is meaningful and consistent.
2. Prevent Errors: Null values can cause errors in queries, calculations, and data processing. By avoiding null values, you reduce the risk of errors.
3. Improve Data Quality: By requiring values for a column, you encourage users to provide accurate and complete data.

Primary Key and NULL Values:
A primary key (PK) cannot contain null values. Here's why:

1. Uniqueness: A primary key is designed to uniquely identify each record in a table. Null values would compromise this uniqueness.
2. Identification: A primary key serves as a unique identifier for each record. Null values would make it impossible to identify records reliably.
3. Referential Integrity: Primary keys are often referenced by foreign keys in other tables. Null values in a primary key would break referential integrity.

According to the relational database theory, a primary key must satisfy the following conditions:

1. Uniqueness: Each value in the primary key column(s) must be unique.
2. Non-Null: Primary key columns cannot contain null values.*/
/*4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
example for both adding and removing a constraint.

Adding Constraints:
To add a constraint to an existing table, you can use the ALTER TABLE statement with the ADD CONSTRAINT clause.

Example: Adding a Unique Constraint
Suppose we have a table called employees with a column called email. We want to ensure that each email address is unique.


ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);


Removing Constraints:
To remove a constraint from an existing table, you can use the ALTER TABLE statement with the DROP CONSTRAINT clause.

Example: Removing a Unique Constraint
Suppose we want to remove the unique constraint on the email column.


ALTER TABLE employees
DROP CONSTRAINT unique_email;


Note:

- Before dropping a constraint, make sure it exists and you have the necessary permissions.
- Some databases may require you to specify the type of constraint (e.g., UNIQUE, PRIMARY KEY, FOREIGN KEY) when dropping it.*/
/*5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint.
Consequences of Violating Constraints:
When attempting to insert, update, or delete data in a way that violates constraints, the database management system (DBMS) will prevent the operation from completing and will generate an error message.

Consequences:
1. Insertion Failure: If a new record violates a constraint, the insertion operation will fail, and the record will not be added to the table.
2. Update Failure: If an update operation violates a constraint, the update will fail, and the data will remain unchanged.
3. Deletion Failure: If a deletion operation violates a constraint, the deletion will fail, and the record will not be deleted.

Example Error Message:
Suppose we have a table called employees with a primary key constraint on the emp_id column. If we try to insert a new record with a duplicate emp_id, the DBMS will generate an error message like this:


ERROR 1062 (23000): Duplicate entry '12345' for key 'PRIMARY'


This error message indicates that the insertion operation failed because the emp_id value '12345' already exists in the table, violating the primary key constraint.

Common Error Messages:
1. Primary Key Violation: "Duplicate entry 'value' for key 'PRIMARY'"
2. Unique Constraint Violation: "Duplicate entry 'value' for key 'UNIQUE'"
3. Foreign Key Violation: "Cannot add or update a child row: a foreign key constraint fails"
4. Check Constraint Violation: "Check constraint 'constraint_name' is violated"*/
/*6.6. You created a products table without constraints as follows:

CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price DECIMAL(10, 2));
    Now, you realise that?
: The product_id should be a primary keyQ
: The price should have a default value of 50.00*/

CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price DECIMAL(10, 2));
    ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  price DECIMAL(10, 2) DEFAULT 50.00
);
SHOW CREATE TABLE products;
/*7. You have two tables

Students Table:*/
CREATE TABLE students (
  student_id INT,
  student_name VARCHAR(50),
  class_id INT
);

INSERT INTO students (student_id, student_name, class_id)
VALUES
  (1, 'Alice', 101),
  (2, 'Bob', 102),
  (3, 'Charlie',101);
SHOW CREATE TABLE students;
SELECT * FROM students;
CREATE TABLE classes (
  class_id INT,
  class_name VARCHAR(50)
);

INSERT INTO classes (class_id, class_name)
VALUES
  (101, 'Class A'),
  (102,'Class B');
  SHOW CREATE TABLE classes;
  SELECT * FROM classes;
  SELECT s.student_name, c.class_name
FROM students s
INNER JOIN classes c
ON s.class_id = c.class_id;
/*8. Consider the following three tables:
 Orders :

| order_id | order_date  | customer_id |
| --- | --- | --- |
| 1        | 2024-01-01 | 101        |
| 2        | 2024-01-03 | 102        |
customers:
| customer_id | customer_name |
| --- | --- |
| 101        | Alice        |
| 102        | Bob           |
products:
| product_id | product_name | order_id |
| --- | --- | --- |
| 1        | Laptop      | 1       |
| 2        | Phone        | NULL    |
Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
listed even if they are not associated with an order 

Hint: (use INNER JOIN and LEFT JOIN)*/

CREATE TABLE Orders (
  order_id INT,
  order_date DATE,
  customer_id INT
);

INSERT INTO Orders (order_id, order_date, customer_id)
VALUES
  (1, '2024-01-01', 101);

INSERT INTO Orders (order_id, order_date, customer_id)
VALUES
  (2, '2024-01-03', 102);

CREATE TABLE Customers (
  customer_id INT,
  customer_name VARCHAR(50)
);


INSERT INTO Customers (customer_id, customer_name)
VALUES
  (101, 'Alice');

INSERT INTO Customers (customer_id, customer_name)
VALUES
  (102, 'Bob');
  
CREATE TABLE Orderss (
  order_id INT,
  order_date DATE,
  customer_id INT
);

INSERT INTO Orders (order_id, order_date, customer_id)
VALUES
  (1, '2024-01-01', 101),
  (2, '2024-01-03', 102);
SELECT 
  o.order_id, 
  c.customer_name, 
  p.product_name
FROM 
  Orders o
  RIGHT JOIN Customers c ON o.customer_id = c.customer_id
  CROSS JOIN Products p
  LEFT JOIN (
    SELECT 
      o.order_id, 
      c.customer_id, 
      p.product_name
    FROM 
      Orders o
      INNER JOIN Customers c ON o.customer_id = c.customer_id
      INNER JOIN Products p ON o.order_id = p.order_id
  ) AS sub
  ON c.customer_id = sub.customer_id 
  AND o.order_id = sub.order_id 
  AND p.product_name = sub.product_name;

/*9.Given the following tables:
| sale_id | product_id | amount |
| --- | --- | --- |
| 1 | 101 | 500 |
| 2 | 102 | 300 |
| 3 | 101 | 700 |

| product_id | product_name |
| --- | --- |
| 101 | Laptop |
| 102 | Phones |
Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.*/
CREATE TABLE Sales (
  sale_id INT,
  product_id INT,
  amount INT
);

INSERT INTO Sales (sale_id, product_id, amount)
VALUES
(1,101,500),
(2,102,300),
(3,101,700);
CREATE TABLE Products (
  product_id INT,
  product_name VARCHAR(50)
);

INSERT INTO Products (product_id, product_name)
VALUES
  (101, 'Laptop'),
  (102, 'Phones');
  SELECT 
  p.product_name,
  SUM(s.amount) AS total_sales_amount
FROM 
  Sales s
  INNER JOIN Products p ON s.product_id = p.product_id
GROUP BY 
  p.product_name;
/*10. You are given three tables:


Orders Table

| order_id | order_date  | customer_id |
| --- | --- | --- |
| 1    | 2024-01-02 | 1          |
| 2    | 2024-01-05 | 2          |

Customers Table

| customer_id | customer_name |
| --- | --- |
| 1          | Alice       |
| 2          | Bob         |

Order_Details Table

| order_id | product_id | quantity |
| --- | --- | --- |
| 1    | 101       | 2       |
| 1    | 102       | 1       |
| 2    | 101       | 13      |
Write a query to display the order_id, customer_name, and the quantity of products ordered by each
customer using an INNER JOIN between all three tables.*/

SELECT o.order_id, c.customer_name, p.product_name
FROM Orders o
RIGHT JOIN Customers c ON o.customer_id = c.customer_id
CROSS JOIN Products p
LEFT JOIN (
  SELECT o.order_id, c.customer_id, p.product_name
  FROM Orders o
  INNER JOIN Customers c ON o.customer_id = c.customer_id
  INNER JOIN Products p ON o.order_id = p.order_id
) AS sub ON c.customer_id = sub.customer_id AND o.order_id = sub.order_id AND p.product_name = sub.product_name;


To find the total sales amount for each product using an INNER JOIN and the SUM() function:


SELECT p.product_name, SUM(s.amount) AS total_sales_amount
FROM Sales s
INNER JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name;

To display the order_id, customer_name, and the quantity of products ordered by each customer using an INNER JOIN between all three tables:


SELECT o.order_id, c.customer_name, od.quantity
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN Order_Details od ON o.order_id = od.order_id
ORDER BY o.order_id;
  
                         SQL COMMANDS
                         




/*1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences
Primary Keys:

1. actor_id (actors table): Unique identifier for each actor.
2. address_id (addresses table): Unique identifier for each address.
3. category_id (categories table): Unique identifier for each category.
4. city_id (cities table): Unique identifier for each city.
5. country_id (countries table): Unique identifier for each country.
6. customer_id (customers table): Unique identifier for each customer.
7. film_id (films table): Unique identifier for each film.
8. inventory_id (inventory table): Unique identifier for each inventory item.
9. language_id (languages table): Unique identifier for each language.
10. payment_id (payments table): Unique identifier for each payment.
11. rental_id (rentals table): Unique identifier for each rental.
12. staff_id (staff table): Unique identifier for each staff member.
13. store_id (stores table): Unique identifier for each store.

Foreign Keys:

1. store_id (customers table): References the primary key store_id in the stores table.
2. address_id (customers table): References the primary key address_id in the addresses table.
3. film_id (inventory table): References the primary key film_id in the films table.
4. store_id (inventory table): References the primary key store_id in the stores table.
5. customer_id (rentals table): References the primary key customer_id in the customers table.
6. inventory_id (rentals table): References the primary key inventory_id in the inventory table.
7. return_id (rentals table): References the primary key rental_id in the rentals table.
8. staff_id (rentals table): References the primary key staff_id in the staff table.
9. film_id (film_actor table): References the primary key film_id in the films table.
10. actor_id (film_actor table): References the primary key actor_id in the actors table.
11. film_id (film_category table): References the primary key film_id in the films table.
12. category_id (film_category table): References the primary key category_id in the categories table.

Differences between Primary Keys and Foreign Keys:

1. Uniqueness: Primary keys are unique identifiers for each row in a table, while foreign keys are not unique and can have duplicate values.
2. Purpose: Primary keys define the identity of a row, while foreign keys establish relationships between tables.
3. Constraints: Primary keys have a NOT NULL constraint, while foreign keys can be NULL.
4. Indexing: Primary keys are automatically indexed, while foreign keys are not.
5. Referential Integrity: Foreign keys ensure referential integrity by preventing actions that would destroy links between tables.*/

/*2- List all details of actors*/

SELECT * 
FROM actors;

/*3.-List all customer information from DB.*/
SELECT 
  customer_id,
  email,
  address_id,
  active,
  create_date,
  last_update
FROM 
  customers;
/*4.-List different countries.*/

SELECT 
  country_id,
  country
FROM 
  countries;
  /*5.Display all active customers.*/
  SELECT 
  customer_id,
  first_name,
  last_name,
  email,
  active
FROM 
  customers
WHERE 
  active = 1;
/*6.-List of all rental IDs for customer with ID 1.*/
SELECT 
  rental_id
FROM 
  rentals
WHERE 
  customer_id = 1;
  /*7. Display all the films whose rental duration is greater than 5 .*/
  SELECT 
  film_id,
  title,
  rental_duration
FROM 
  films
WHERE 
  rental_duration > 5;
/*8. List the total number of films whose replacement cost is greater than $15 and less than $20.*/
SELECT 
  COUNT(film_id) AS total_films
FROM 
  films
WHERE 
  replacement_cost > 15 AND replacement_cost < 20;
/*9. Display the count of unique first names of actors.*/
SELECT 
  COUNT(DISTINCT first_name) AS unique_first_names
FROM 
  actors;
/*10. Display the first 10 records from the customer table */
SELECT 
  *
FROM 
  customers
LIMIT 10;
/*11. Display the first 3 records from the customer table whose first name starts with ‘b*/
SELECT 
  *
FROM 
  customers
WHERE 
  first_name LIKE 'B%'
LIMIT 3;
/*12Display the names of the first 5 movies which are rated as ‘G’.*/
SELECT 
  title
FROM 
  films
WHERE 
  rating = 'G'
LIMIT 5;
/*13.Find all customers whose first name starts with "a".*/
SELECT 
  *
FROM 
  customers
WHERE 
  first_name LIKE 'A%';
/*14.- Find all customers whose first name ends with "a".*/
SELECT 
  *
FROM 
  customers
WHERE 
  first_name LIKE '%a';
/*15.- Display the list of first 4 cities which start and end with ‘a’ */

SELECT 
  city
FROM 
  cities
WHERE 
  city LIKE 'A%A'
LIMIT 4;
/*16. Find all customers whose first name have "NI" in any position*/

SELECT 
  *
FROM 
  customers
WHERE 
  first_name LIKE '%NI%';
/*17. Find all customers whose first name have "r" in the second position */
SELECT 
  *
FROM 
  customers
WHERE 
  first_name LIKE '_R%';
/*18.Find all customers whose first name starts with "a" and are at least 5 characters in length*/
SELECT 
  *
FROM 
  customers
WHERE 
  first_name LIKE 'A%' AND LENGTH(first_name) >= 5;
/*19.- Find all customers whose first name starts with "a" and ends with "o".*/
SELECT 
  *
FROM 
  customers
WHERE 
  first_name LIKE 'A%O';
/*20. Get the films with pg and pg-13 rating using IN operator*/
SELECT 
  *
FROM 
  films
WHERE 
  rating IN ('PG', 'PG-13');
/*21.- Get the films with length between 50 to 100 using between operator*/

SELECT 
  *
FROM 
  films
WHERE 
  length BETWEEN 50 AND 100;
/*22. Get the top 50 actors using limit operator.*/
SELECT 
  *
FROM 
  actors
LIMIT 50;
/*23.Get the distinct film ids from inventory table.*/

SELECT 
  DISTINCT film_id
FROM 
  inventory;
       
       
                            /*FUNCTIONS*/
/*Question 1:
Retrieve the total number of rentals made in the Sakila database.
Hint: Use the COUNT() function*/
SELECT 
  COUNT(*) AS total_rentals
FROM 
  rental;

                            
















