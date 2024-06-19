use amazon;

-- JOINS
-- INNER JOIN
SELECT customer.cid, orders.oid, customer.cname, orders.amt FROM orders 
INNER JOIN customer ON orders.cid = customer.cid;

-- LEFT OUTER JOIN
SELECT orders.oid,orders.amt,products.pid,products.pname FROM products 
LEFT OUTER JOIN orders ON orders.pid = products.pid;

-- RIGHT OUTER JOIN
SELECT orders.oid,orders.pid, payment.pay_id,payment.amount FROM payment 
RIGHT OUTER JOIN orders ON orders.oid = payment.oid;

-- FULL JOIN
SELECT orders.oid, products.pid, products.pname, orders.amt, products.price, products.stock, products.location FROM orders
LEFT JOIN products ON orders.pid = products.pid
UNION
SELECT orders.oid, products.pid, products.pname, orders.amt, products.price, products.stock, products.location FROM orders
RIGHT JOIN products ON orders.pid = products.pid;

-- SELF JOIN
SELECT p1.pid, p1.pname, p1.price, p1.stock, p1.location AS "Location 1", p2.location AS "Location 2"
FROM PRODUCTS AS p1
JOIN PRODUCTS AS p2
ON p1.stock = p2.stock AND p1.pid <> p2.pid;

-- CROSS JOIN
SELECT orders.oid, cname, pname, amount, status,location FROM orders
CROSS JOIN products ON orders.pid = products.pid
CROSS JOIN customer ON orders.cid = customer.cid
CROSS JOIN payment ON orders.oid = payment.oid
WHERE status IN ("in prodess","pending");

-- ANOMALIES
-- UPDATE ANOMALY
UPDATE products 
SET price = 52000
WHERE pid = 1;

-- DELETE ANOMALY
DELETE FROM products
WHERE pid = 5;

-- INSERTION ANOMALY
INSERT INTO orders
VALUES (10005,106,2,1);