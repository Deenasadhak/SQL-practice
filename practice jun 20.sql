use amazon;

-- SUBQUERIES
-- SINGLE ROW SUBQUERIES
SELECT cname 
FROM customer 
WHERE cid = (SELECT cid FROM orders ORDER BY amt DESC LIMIT 1);

-- MULTIPLE ROW SUBQUERIES
SELECT cname
FROM customer
WHERE cid IN (SELECT cid FROM orders);

-- CORRELATED SUBQUERIES
SELECT pname, price
FROM products p
WHERE price > ( SELECT AVG(price)
FROM products
WHERE location = p.location
);

-- INNER JOIN WITH SUBQUERY
SELECT p.pname, o.oid,o.amt
FROM products p
INNER JOIN(
SELECT * 
FROM orders) o ON p.pid = o.oid
WHERE p.price > 1000;

-- LEFT JOIN WITH AGGREGATE FUNCTIONS
SELECT p.pname, SUM(o.amt) AS total_orders_amount
FROM products p
LEFT JOIN orders o ON p.pid = o.oid
GROUP BY p.pname;

-- RIGHT JOIN WITH DATE AND TIME FUNCTIONS
SELECT o.oid, o.amt, p.status, p.timestamp
FROM orders o
RIGHT JOIN payment p ON o.oid = p.pid;

-- RANK
SELECT pid,pname,price, RANK() OVER(ORDER BY price DESC) AS price_rank
FROM products;

-- DENSE_RANK
SELECT pid,pname,price, DENSE_RANK() OVER(ORDER BY price DESC) AS price_rank
FROM products;

-- ROW NUMBER
SELECT ROW_NUMBER() OVER (ORDER BY age DESC) AS row_num, cid, cname, age, address
FROM customer;

-- CUME_DIST
SELECT oid,amount,CUME_DIST() OVER (ORDER BY amount) AS cumulative_distribution
FROM payment;

-- LAG
SELECT pname,price,location,LAG(price) OVER (PARTITION BY location ORDER BY price) AS lag_price
FROM products;

-- LEAD
SELECT pname,price,location,LEAD(price) OVER (PARTITION BY location ORDER BY price) AS lead_price
FROM products;