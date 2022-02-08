/* SQL Exercise
====================================================================
We will be working with database northwind.db we have set up and connected to in the activity Connect to Remote PostgreSQL Database earlier.


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE

*/
SELECT table_name
  FROM information_schema.tables
 WHERE table_schema='public'
   AND table_type='BASE TABLE';


--==================================================================
/* TASK I
-- Q1. Write a query to get Product name and quantity/unit.
*/

SELECT ProductName, QuantityPerUnit FROM Products;

/* TASK II
Q2. Write a query to get most expense and least expensive Product list (name and unit price)
*/

SELECT ProductName, UnitPrice FROM Products
    WHERE UnitPrice IN (SELECT MIN(UnitPrice) FROM Products)
    OR UnitPrice IN (SELECT MAX(UnitPrice) FROM Products);

/* TASK III
Q3. Write a query to count current and discontinued products.
*/

SELECT COUNT(ProductName) FROM Products
    GROUP BY Discontinued;

/* TASK IV
Q4. Select all product names and their category names (77 rows)
*/

SELECT ProductName, CategoryName FROM Products
    JOIN Categories ON Categories.CategoryID = Products.CategoryID;

/* TASK V
Q5. Select all product names, unit price and the supplier region that don't have suppliers from USA region. (26 rows)
*/

SELECT ProductName, UnitPrice, Region FROM Products
    JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
    WHERE Region <> 'USA';

/* TASK VI
Q6. Get the total quantity of orders sold.( 51317)
*/

SELECT SUM(Quantity) FROM order_details;

/* TASK VII
Q7. Get the total quantity of orders sold for each order.(830 rows)
*/

SELECT OrderID, SUM(Quantity) From order_details
    GROUP BY OrderID;

/* TASK VIII
Q8. Get the number of employees who have been working more than 5 year in the company. (9 rows)
*/

SELECT FirstName, LastName FROM Employees WHERE EXTRACT(YEAR FROM age(CURRENT_DATE, hiredate)) > 5;