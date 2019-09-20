-- Another clever use of SUBQUERIES

-- EXAMPLE: What is the average customer lifetime spending?

-- Does this work?

SELECT AVG(SUM(amount))
FROM payment
GROUP BY customer_id; --NOPE! "ERROR:  aggregate function calls cannot be nested"


--TRY THIS
SELECT AVG(total)
FROM (SELECT SUM(amount) as total 
	  FROM payment 
	  GROUP BY customer_id) as customer_totals; --NICE! 
-- IMPORTANT! NOTICE THE ALIAS AT THE END. THIS IS NECESSARY WHEN THE SUBQUERY
-- IS IN THE FROM CLAUSE

--OR do the above with a CTE:
WITH customer_totals as ( --start of CTE
SELECT SUM(amount) as total 
FROM payment 
GROUP BY customer_id) --end of CTE
SELECT AVG(total)
FROM customer_totals;

-- YOUR TURN: what is the average of the amount of stock each store has in their inventory? (Use inventory table)


WITH store_inventory as 
(SELECT 
store_id, COUNT(inventory_id) as total
FROM
inventory 
GROUP BY store_id)
SELECT 
avg(total) as average_stock_in_stores
FROM
store_inventory;


 average_stock_in_stores 
-------------------------
   2290.5000000000000000
(1 row)



-- YOUR TURN: What is the average customer lifetime spending, for each staff member?
-- HINT: you can work off the example






--YOUR TURN: 
--What is the average number of films we have per genre (category)?

WITH total_film_per_category as 
(SELECT 
category_id, COUNT(film_id) as total_film
FROM
film_category
GROUP BY category_id)
SELECT 
avg(total_film) as average_film_per_category
FROM
total_film_per_category;



 average_film_per_category 
---------------------------
       62.5000000000000000
(1 row)

