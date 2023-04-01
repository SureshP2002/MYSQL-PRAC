-- -------------------------DATABASES-------------------------
CREATE DATABASE MYDB; 
DROP DATABASE MYDB;
ALTER DATABASE MYDB READ ONLY=1; --  TO READ
ALTER DATABASE MYDB READ ONLY=0;  -- TO MAKE READ AND WRITE
 -- USE MYDB;
 
 
 
 
-- --------------------------TABLE---------------------
CREATE TABLE EMPLOYEES(
EMP_ID INT,
FIRST_NAME VARCHAR(30),
LAST_NAME VARCHAR(30),
PAY DECIMAL(6,2),
HIRE_DATE DATE
)
SELECT *FROM EMPLOYEES;
RENAME TABLE WORKERS TO EMPLOYEES;
DROP TABLE EMPLOYEES;
ALTER TABLE EMPLOYEES
ADD PH_NO VARCHAR(15);
ALTER TABLE EMPLOYEES 
RENAME COLUMN PH_NO TO EMAIL;
ALTER TABLE employees
modify column EMAIL VARCHAR(100);
ALTER TABLE employees
modify EMAIL VARCHAR(100)
AFTER LAST_NAME;
ALTER TABLE employees 
DROP column EMAIL;

INSERT INTO employees 
VALUES(1,"SURESH","P",800.88,"2023-03-23"),
(2,"SURYA","R",5660.5,"2023-03-22"),
(3,"SOUNDAR","KARTHICK",456.99,"2023-03-22"),
(4,"PAVI","P",3455.99,"2023-05-21");
SELECT * FROM  employees; 



-- ------------------SELECT --------------------------------
SELECT * FROM employees;

SELECT first_name, last_name FROM employees;

SELECT last_name, first_name FROM employees;

SELECT *
FROM employees
WHERE employee_id = 1;

SELECT *
FROM employees
WHERE first_name = "Spongebob";

SELECT *
FROM employees
WHERE hourly_pay >= 15;

SELECT hire_date, first_name
FROM employees
WHERE hire_date <= "2023-01-03";

SELECT *
FROM employees
WHERE employee_id != 1;

SELECT *
FROM employees
WHERE hire_date IS NULL;

SELECT *
FROM employees
WHERE hire_date IS NOT NULL;




-- -------------------------UPDATE AND DELETE--------------------------
UPDATE employees
SET hourly_pay = 10.25
WHERE employee_id = 6;
SELECT * FROM employees;

DELETE FROM employees
WHERE employee_id = 6;
SELECT * FROM employees;



-- ----------------------------AUTOCOMMIT ,COMMIT ,ROLLBACK----------------------
-- In case you accidentally delete all the rows AND THEN commit, here's the rows again:

INSERT INTO employees 
VALUES	(1, 'Eugene', 'Krabs', 25.50, '2023-01-02'),
		(2, 'Squidward', 'Tentacles', 15.00, '2023-01-03'),
		(3, 'Spongebob', 'Squarepants', 12.50, '2023-01-04'),
		(4, 'Patrick', 'Star', 12.50, '2023-01-05'),
		(5, 'Sandy', 'Cheeks', 17.25, '2023-01-06');
        
        
 --  -------------------------------CURRENT_DATE(),CURRENT_TIME(),NOW()----------------------------
 CREATE TABLE test(
     my_date DATE,
     my_time TIME,
     my_datetime DATETIME
);

INSERT INTO test
VALUES(CURRENT_DATE(), CURRENT_TIME(), NOW());
SELECT * FROM test;


-- --------------------------UNIQUE CONSTRAINT-------------------------------
CREATE TABLE products (
    product_id INT,
    product_name varchar(25) UNIQUE,
    price DECIMAL(4, 2)
);

ALTER TABLE products
ADD CONSTRAINT 
UNIQUE (product_name);

INSERT INTO products
VALUES (100, 'hamburger', 3.99),
               (101, 'fries', 1.89),
               (102, 'soda', 1.00),
               (103, "ice cream", 1.49);

SELECT * FROM products;



--  -------------------------NOT NULL CONSTRAINT------------------------
CREATE TABLE products (
    product_id INT,
    product_name varchar(25),
    price DECIMAL(4, 2) NOT NULL
);

ALTER TABLE products
MODIFY price DECIMAL(4, 2) NOT NULL;

INSERT INTO products
VALUES(104, "cookie", NULL);



-- ------------------------------CHECK CONSTRAINT-------------------------
– The CHECK constraint is used to limit what values can be placed in a column.

CREATE TABLE employees(
	employee_id INT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	hourly_pay DECIMAL (5, 2),
	hire_date DATE, 
	CONSTRAINT chk_hourly_pay CHECK (hourly_pay >= 10.00)
);

ALTER TABLE employees
ADD CONSTRAINT chk_hourly_pay CHECK (hourly_pay >= 10.00);

INSERT INTO employees
VALUES (6, "Sheldon", "Plankton", 5.00, "2023-01-07");

ALTER TABLE employees
DROP CHECK chk_hourly_pay;



--  ----------------------DEFAULT CONSTRAINT-------------------------------------------------
-- EXAMPLE 1
CREATE TABLE products (
    product_id INT,
    product_name varchar(25),
    price DECIMAL(4, 2) DEFAULT 0
);

ALTER TABLE products 
ALTER price SET DEFAULT 0;

INSERT INTO products (product_id, product_name)
VALUES	(104, "straw"),
		(105, "napkin"),
		(106, "fork"),
        	(107, "spoon");
SELECT * FROM products;

– EXAMPLE 2
CREATE TABLE transactions(
        transaction_id INT,
    	amount DECIMAL(5, 2),
   	transaction_date DATETIME DEFAULT NOW()
);
SELECT * FROM transactions;

INSERT INTO transactions (transaction_id, amount)
VALUES	(1, 4.99);
SELECT * FROM transactions;

INSERT INTO transactions (transaction_id, amount)
VALUES	(2, 2.89);
SELECT * FROM transactions;

INSERT INTO transactions (transaction_id, amount)
VALUES	(3, 8.37);
SELECT * FROM transactions;

DROP TABLE transactions;



-- -------------------PRIMARY KEY------------------------------------------------------
-- EXAMPLE 1 --

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    amount DECIMAL(5, 2)
);

-- EXAMPLE 2 --

ALTER TABLE transactions
ADD CONSTRAINT
PRIMARY KEY (transaction_id);



 -- ------------------- AUTO INCREAMENT--------------------------------------------
 -- AUTO_INCREMENT keyword used to automatically create a sequence of a column when inserting data. Applied to a column set as a ‘key’.

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5, 2)
);

ALTER TABLE transactions 
AUTO_INCREMENT = 1000;



-- -------------------FOREIGN KEY----------------------------------------------------------
CREATE TABLE customers (
     customer_id INT PRIMARY KEY AUTO_INCREMENT,
     first_name VARCHAR(50),
     last_name VARCHAR(50)
);
INSERT INTO customers (first_name, last_name)
VALUES  ("Fred", "Fish"),
                ("Larry", "Lobster"),
                ("Bubble", "Bass");
SELECT * FROM customers;

-- Add a named foreign key constraint to a new table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5, 2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
ALTER TABLE transactions
AUTO_INCREMENT = 1000;

-- Add a named foreign key constraint to an existing table
ALTER TABLE customers
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);



--   ----------------------------------JOINS---------------------------------------------
- INNER JOIN selects records that have a matching key in both tables.
SELECT *
FROM transactions INNER JOIN customers
ON transactions.customer_id = customers.customer_id;

-- LEFT JOIN returns all records from the left table 
-- and the matching records from the right table
SELECT *
FROM transactions LEFT JOIN customers
ON transactions.customer_id = customers.customer_id;

-- RIGHT JOIN returns all records from the right table 
-- and the matching records from the left table
SELECT *
FROM transactions RIGHT JOIN customers
ON transactions.customer_id = customers.customer_id;


-- ---------------------------------------FUNCTIONS()-------------------------------
SELECT COUNT(amount) as count
FROM transactions;

SELECT MAX(amount) AS maximum
FROM transactions;

SELECT MIN(amount) AS minimum
FROM transactions;

SELECT AVG(amount) AS average
FROM transactions;

SELECT SUM(amount) AS sum
FROM transactions;

SELECT CONCAT(first_name, “ ”, last_name) AS full_name
FROM employees;



-- -------------------------LOGICAL OPERATORS-------------------------------------------
SELECT * FROM employees
WHERE hire_date  > '2023-01-05' AND job = “cook”;

SELECT * FROM employees
WHERE job = 'Cook' OR job = 'Cashier';

SELECT * FROM employees
WHERE NOT job = 'Manager';

SELECT * FROM employees
WHERE NOT job = 'Manager' AND NOT job = 'Asst. Manager';

SELECT *
FROM employees
WHERE hire_date BETWEEN '2023-01-04' AND '2023-01-07';

SELECT * 
FROM employees
WHERE job IN ("cook", "cashier", "janitor");



--   -------------------------------WILD CARDS--------------------------------------
% = any amount of random characters
_ = one single random character

SELECT * FROM employees
WHERE first_name LIKE "s%";

SELECT * FROM employees
WHERE last_name LIKE "%r";

SELECT * FROM employees
WHERE hire_date LIKE "2023%";

SELECT * FROM employees
WHERE job LIKE "_ook";

SELECT * FROM employees
WHERE hire_date LIKE "__-01-__";

SELECT * FROM employees
WHERE job LIKE "_a%";


-- ------------------------ORDER BY----------------------------------------------------
SELECT * FROM employees
ORDER BY last_name ASC;

SELECT * FROM transactions
ORDER BY amount DESC, customer_id DESC;


-- ----------------------LIMIT- -----------------------------------------------------
   SELECT * FROM customers
LIMIT 1;

SELECT *FROM customers
LIMIT 2;

SELECT * FROM customers
LIMIT 3;

SELECT * FROM customers
ORDER BY last_name DESC
LIMIT 3;

SELECT * FROM customers
ORDER BY last_name ASC
LIMIT 3;

SELECT * FROM customers
LIMIT 1, 3;


-- ------------------------------UNION-----------------------------------------------
-- NO DUPLICATES
SELECT first_name, last_name FROM employees
UNION
SELECT first_name, last_name FROM customers;

-- DUPLICATES OK
SELECT first_name, last_name FROM employees
UNION ALL
SELECT first_name, last_name FROM customers;




--  -----------------------------SELF JOIN-------------------------------------------
SELECT a.first_name, a.last_name,
               CONCAT(b.first_name," ", b.last_name) AS "reports_to"
FROM employees AS a
INNER JOIN employees AS b
ON a.supervisor_id = b.employee_id;


-- ---------------------------------VIEWS--------------------------------------------
-- VIEW IS VIRTUAL TABLE NOT REAL
CREATE VIEW employee_attendance AS 
SELECT first_name, last_name
FROM employees;

CREATE VIEW customer_emails AS 
SELECT email
FROM customers;


--  -------------------------------INDECES--------------------------------------------
-- INDEX (BTree data structure)
-- Indexes are used to find values within a specific column more quickly
-- MySQL normally searches sequentially through a column
-- The longer the column, the more expensive the operation is
-- UPDATE takes more time, SELECT takes less time

-- Single column index
CREATE INDEX last_name_idx
ON customers (last_name);

-- Multi column index
CREATE INDEX last_name_first_name_idx
ON customers (last_name, first_name);


-- -------------------------------    SUBQUERIES-----------------------------------------
SELECT first_name, last_name, hourly_pay, 
       (SELECT AVG(hourly_pay) FROM employees) AS avg_pay
FROM employees;

SELECT first_name, last_name
FROM employees
WHERE hourly_pay > (SELECT AVG(hourly_pay) FROM employees);

SELECT first_name, last_name
FROM customers
WHERE customer_id IN (SELECT DISTINCT customer_id
FROM transactions WHERE customer_id IS NOT NULL);

SELECT first_name, last_name
FROM customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id
FROM transactions WHERE customer_id IS NOT NULL);


--   ----------------------------GROUP BY---------------------------------------
DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5, 2),
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) 
    REFERENCES customers(customer_id)
);

INSERT INTO transactions
VALUES 	(1000, 4.99, 3, "2023-01-01"),
		(1001, 2.89, 2, "2023-01-01"),
		(1002, 3.38, 3, "2023-01-02"),
		(1003, 4.99, 1, "2023-01-02"),
		(1004, 1.00, NULL, "2023-01-03"),
		(1005, 2.49, 4, "2023-01-03"),
		(1006, 5.48, NULL, "2023-01-03");
        
SELECT * FROM transactions;
------------------------------------------------------------

-- EXAMPLE 1 --
SELECT SUM(amount), order_date
FROM transactions 
GROUP BY order_date;

-- EXAMPLE 2 --
SELECT COUNT(amount), customer_id
FROM transactions 
GROUP BY customer_id
HAVING COUNT(amount) > 1 AND customer_id IS NOT NULL;



-- ---------------------ROLL UP----------------------
-- ROLLUP, extension of the GROUP BY clause 
-- produces another row and shows the grand-total (super-aggregate) value

SELECT SUM(amount) AS "daily_sales", order_date
FROM transactions
GROUP BY order_date WITH ROLLUP;

SELECT COUNT(transaction_id) AS "# of orders", order_date
FROM transactions
GROUP BY order_date WITH ROLLUP;

SELECT COUNT(transaction_id) AS "# of orders", customer_id
FROM transactions
GROUP BY customer_id WITH ROLLUP;

SELECT SUM(hourly_pay) AS "hourly_pay", employee_id
FROM employees
GROUP BY employee_id WITH ROLLUP;  
 
-- ----------------------------TRIGGERS--------------------------------------------
CREATE TRIGGER before_hourly_pay_update
BEFORE UPDATE ON employees 
FOR EACH ROW
SET NEW.salary = (NEW.hourly_pay * 2080);

CREATE TRIGGER before_hourly_pay_insert
BEFORE INSERT ON employees 
FOR EACH ROW
SET NEW.salary = (NEW.hourly_pay * 2080);

CREATE TRIGGER after_salary_delete
AFTER DELETE ON employees 
FOR EACH ROW
UPDATE expenses
SET expense_total = expense_total - OLD.salary
WHERE expense_name = "salaries";

CREATE TRIGGER after_salary_insert
AFTER INSERT ON employees 
FOR EACH ROW
UPDATE expenses
SET expense_total = expense_total + NEW.salary
WHERE expense_name = "salaries";

CREATE TRIGGER after_salary_update
AFTER UPDATE ON employees 
FOR EACH ROW
UPDATE expenses
SET expense_total = expense_total + (NEW.salary - OLD.salary)
WHERE expense_name = "salaries"; 

 
