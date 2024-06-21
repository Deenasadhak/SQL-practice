-- DELIMITER COMMAND
DELIMITER $$
CREATE PROCEDURE get_sellers()
BEGIN
SELECT * FROM sellers;
END $$
DELIMITER ;


-- PROCEDURES
DELIMITER // 
CREATE PROCEDURE select_all_products()
BEGIN
SELECT * FROM products;
END //
DELIMITER ;

-- CALLING PROCEDURE
CALL select_all_products();

-- DROPPING PROCEDURES
DROP PROCEDURE select_all_products;

-- FUNCTIONS
DELIMITER $$
CREATE FUNCTION get_total_revenue()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE total_revenue DECIMAL(10,2);
SELECT SUM(o.total_amount) INTO total_revenue
FROM orders o
WHERE o.order_status = 'Shipped';
RETURN total_revenue;
END $$
DELIMITER ;

-- FUNCTION EXECUTION
SELECT get_total_revenue();

-- DROPPING FUNCTION
DROP FUNCTION IF EXISTS get_total_revenue;

-- IN
DELIMITER // 
CREATE PROCEDURE get_product_details(IN product_id VARCHAR(20))
BEGIN
SELECT * FROM products WHERE asin = product_id;
END // 

-- CALLING PROCEDURE
CALL get_product_details('B076MX9VG9');

-- OUT
DELIMITER // 
CREATE PROCEDURE get_product_count(OUT product_count INT)
BEGIN
SELECT COUNT(*) INTO product_count FROM products;
END // 

-- CALLING PROCEDURE
CALL get_product_count(@product_count);
SELECT @product_count as product_count;

-- CURSOR
DELIMITER //
DECLARE @seller_count INT;
SELECT @seller_count = COUNT(*)
FROM sellers;
PRINT 'Number of sellers: ' + CAST(@seller_count AS VARCHAR(10));
DELIMITER ;

-- PREDEFINED CURSOR
DELIMITER //
DECLARE @total_rating DECIMAL(3,2);
SELECT @total_rating = AVG(r.rating)
FROM reviews r
WHERE r.product_id = 'B076MX9VG9';
PRINT 'Average rating of product B076MX9VG9: ' + CAST(@total_rating AS VARCHAR(5));
DELIMITER ;