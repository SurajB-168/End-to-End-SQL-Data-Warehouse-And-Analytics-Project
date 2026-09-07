-- =============================
-- DATA ANALYTICS USING SQL PROJECT
-- =============================



-- =============================
-- Exploring the data
-- =============================
SELECT *
FROM gold.dim_customers
;

SELECT *
FROM gold.dim_products
;

SELECT *
FROM gold.fact_sales
;



-- =============================
-- Explore all countries our customer come from
-- =============================
SELECT DISTINCT country
FROM gold.dim_customers
;

SELECT COUNT(DISTINCT country) AS count_of_countries
FROM gold.dim_customers
;



-- =============================
-- Explore all categories, subcategories and products in products
-- =============================
SELECT DISTINCT category, subcategory, product_name
FROM gold.dim_products
ORDER BY 1, 2, 3
;

SELECT COUNT(DISTINCT category) AS category_count, COUNT(DISTINCT subcategory) AS subcategory_count, COUNT(DISTINCT product_name) AS product_count
FROM gold.dim_products
;

SELECT category, COUNT(DISTINCT subcategory) AS subcategory_count, COUNT(DISTINCT product_name) AS product_count
FROM gold.dim_products
GROUP BY category
;


-- =============================
-- Date of first and last order, how many years of sales are available
-- =============================
SELECT MIN(order_date) AS first_order_date, MAX(order_date) AS last_order_date
FROM gold.fact_sales
;

SELECT DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales
;



-- =============================
-- Youngest and oldest customer's birth date and age
-- =============================
SELECT MIN(birthdate) AS oldest_customer_birthdate, DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_customer_age,
		MAX(birthdate) AS youngest_customer_birthdate, DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_customer_age
FROM gold.dim_customers
;



-- =============================
-- Find the total sales
-- =============================
SELECT SUM(sales_amount) AS total_sales
FROM gold.fact_sales
;



-- =============================
-- Find how many items are sold
-- =============================
SELECT SUM(quantity) AS total_sold_items
FROM gold.fact_sales
;



-- =============================
-- Find the average selling price
-- =============================
SELECT AVG(price) AS average_price
FROM gold.fact_sales
;



-- =============================
-- Find the total number of orders
-- =============================
SELECT COUNT(order_number) AS total_orders_count
FROM gold.fact_sales
;

SELECT COUNT(DISTINCT order_number) AS distinct_total_orders_count
FROM gold.fact_sales
;



-- =============================
-- Find total number of products
-- =============================
SELECT COUNT(DISTINCT product_name) AS product_count
FROM gold.dim_products
;



-- =============================
-- Find total number of customers
-- =============================
SELECT COUNT(customer_id) AS total_customer_count
FROM gold.dim_customers
;



-- =============================
-- Find total number of customers who have placed an order
-- =============================
SELECT COUNT(DISTINCT customer_key) AS customer_count
FROM gold.fact_sales
;
-- Total number of customeres and total number of customers who have placed an order are same, because all registered customers have placed an order.



-- =============================
-- Generate a table that shows all key metrices of the business
-- =============================
SELECT 'Total Sales' AS Measure_name, ROUND(SUM(sales_amount)) AS Measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Sold Items' AS Measure_name, ROUND(SUM(quantity)) AS Measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Average Price' AS Measure_name, ROUND(AVG(price)) AS Measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders Count' AS Measure_name, ROUND(COUNT(DISTINCT order_number), 0) AS Measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Products Count' AS Measure_name, ROUND(COUNT(DISTINCT product_name)) AS Measure_value FROM gold.dim_products
UNION ALL
SELECT 'Total Customers Count' AS Measure_name, ROUND(COUNT(DISTINCT customer_key)) AS Measure_value FROM gold.fact_sales
;



-- =============================
-- Find total customers, purchasing customers, total revenue by country
-- =============================
SELECT country, COUNT(DISTINCT gold.dim_customers.customer_id) AS total_customers, COUNT(DISTINCT gold.fact_sales.customer_key) AS purchasing_customers,
SUM(sales_amount) AS total_revenue
FROM gold.dim_customers
LEFT JOIN gold.fact_sales
ON gold.fact_sales.customer_key = gold.dim_customers.customer_key
GROUP BY country
ORDER BY country
;



-- =============================
-- Find total customers and total revenue by gender
-- =============================
SELECT gender, COUNT(gold.dim_customers.customer_key) AS total_customers, SUM(sales_amount) AS total_revenue
FROM gold.dim_customers
LEFT JOIN gold.fact_sales
ON gold.dim_customers.customer_key = gold.fact_sales.customer_key
GROUP BY gender
;



-- =============================
-- Find total customers and total revenue by marital status
-- =============================
SELECT marital_status, COUNT(gold.dim_customers.customer_key) AS total_customers, SUM(sales_amount) AS total_revenue
FROM gold.dim_customers
LEFT JOIN gold.fact_sales
ON gold.dim_customers.customer_key = gold.fact_sales.customer_key
GROUP BY marital_status
;



-- =============================
-- Find total products by category
-- =============================
SELECT category, COUNT(product_id) AS total_products
FROM gold.dim_products
GROUP BY category
;



-- =============================
-- What is the average cost in each category
-- =============================
SELECT category, ROUND(AVG(cost), 2) AS avg_price
FROM gold.dim_products
GROUP BY category
ORDER BY avg_price DESC
;



-- =============================
-- What is the total revenue generated for each category
-- =============================
SELECT category, SUM(sales_amount) AS total_revenue
FROM gold.fact_sales
LEFT JOIN gold.dim_products
ON gold.fact_sales.product_key = gold.dim_products.product_key
GROUP BY category
ORDER BY total_revenue DESC
;



-- =============================
-- Find total revenue generated by each customer
-- =============================
SELECT customer_id, first_name, last_name, SUM(sales_amount) AS total_revenue
FROM gold.fact_sales
LEFT JOIN gold.dim_customers
ON gold.fact_sales.customer_key = gold.dim_customers.customer_key
GROUP BY customer_id, first_name, last_name
ORDER BY total_revenue DESC
;



-- =============================
-- Top 10 customers who have generated the highest revenue
-- =============================
SELECT *
FROM
	(SELECT customer_id, first_name, last_name, SUM(sales_amount) AS total_revenue,
	DENSE_RANK() OVER(ORDER BY SUM(sales_amount) DESC) AS customer_rank
	FROM gold.fact_sales
	LEFT JOIN gold.dim_customers
	ON gold.fact_sales.customer_key = gold.dim_customers.customer_key
	GROUP BY customer_id, first_name, last_name) AS new_table
WHERE customer_rank <= 10
;



-- =============================
-- What is the distribution of sold items across countries
-- =============================
SELECT country, SUM(quantity) AS total_sold_items
FROM gold.fact_sales
LEFT JOIN gold.dim_customers
ON gold.fact_sales.customer_key = gold.dim_customers.customer_key
GROUP BY country
ORDER BY total_sold_items DESC
;



-- =============================
-- Which 5 products generate the highest revenue
-- =============================
SELECT *
FROM
	(SELECT gold.fact_sales.product_key, gold.dim_products.product_name, SUM(sales_amount) AS revenue,
	DENSE_RANK() OVER(ORDER BY SUM(sales_amount) DESC) AS product_rank
	FROM gold.fact_sales
	LEFT JOIN gold.dim_products
	ON gold.fact_sales.product_key = gold.dim_products.product_key
	GROUP BY gold.fact_sales.product_key, gold.dim_products.product_name) AS new_table
WHERE product_rank <= 5
;



-- =============================
-- Which products have not made any sale
-- =============================
SELECT gold.fact_sales.product_key, gold.dim_products.product_name, SUM(sales_amount) AS revenue
FROM gold.dim_products
LEFT JOIN gold.fact_sales
ON gold.fact_sales.product_key = gold.dim_products.product_key
GROUP BY gold.fact_sales.product_key, gold.dim_products.product_name
HAVING revenue IS NULL
;



-- =============================
-- What are the 5 worst performing products in terms of sales
-- =============================
SELECT *
FROM
	(SELECT gold.fact_sales.product_key, gold.dim_products.product_name, SUM(sales_amount) AS revenue,
	DENSE_RANK() OVER(ORDER BY SUM(sales_amount)) AS product_rank
	FROM gold.fact_sales
	LEFT JOIN gold.dim_products
	ON gold.fact_sales.product_key = gold.dim_products.product_key
	GROUP BY gold.fact_sales.product_key, gold.dim_products.product_name) AS new_table
WHERE product_rank <= 5
;



-- =============================
-- Bottom 3 custoemers with the fewest orders places
-- =============================
SELECT *
FROM 
	(SELECT gold.fact_sales.customer_key, first_name, last_name, COUNT(order_number) AS order_count,
	ROW_NUMBER() OVER(ORDER BY COUNT(order_number)) AS customer_rank
	FROM gold.fact_sales
	LEFT JOIN gold.dim_customers
	ON gold.fact_sales.customer_key = gold.dim_customers.customer_key
	GROUP BY gold.fact_sales.customer_key, first_name, last_name) AS new_table
WHERE customer_rank <= 3
ORDER BY customer_rank
;



-- =============================
-- Analyze sales performance over time (ALL DATES)
-- =============================
SELECT order_date, SUM(sales_amount) AS total_sales
FROM gold.fact_sales
GROUP BY order_date
ORDER BY order_date
;



-- =============================
-- Analyze sales performance YEAR wise
-- =============================
SELECT FORMAT(order_date, 'yyyy') AS order_year,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy')
ORDER BY FORMAT(order_date, 'yyyy')
;

SELECT YEAR(order_date) AS order_year,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)
;



-- =============================
-- Analyze sales performance MONTH wise
-- =============================
SELECT FORMAT(order_date, 'MMM') AS month,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date), FORMAT(order_date, 'MMM')
ORDER BY MONTH(order_date)
;

SELECT MONTH(order_date) AS order_month, SUM(sales_amount) AS total_sales,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date)
;



-- =============================
-- Analyze sales performance DAY wise
-- =============================
SELECT FORMAT(order_date, 'ddd') AS order_day,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATEPART(WEEKDAY, order_date), FORMAT(order_date, 'ddd')
ORDER BY DATEPART(WEEKDAY, order_date)
;

-- 1 = Sunday, 2 = Monday, ....., 7 = Saturday
SELECT DATEPART(WEEKDAY, order_date) AS order_day,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATEPART(WEEKDAY, order_date)
ORDER BY DATEPART(WEEKDAY, order_date)
;



-- =============================
-- Total sales per month over the period of 5 years
-- =============================
SELECT FORMAT(order_date, 'yyyy-MM') AS order_month, SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY FORMAT(order_date, 'yyyy-MM');



-- =============================
-- Running/Cumulative total sales over time
-- =============================
SELECT order_month, total_sales, SUM(total_sales) OVER(ORDER BY order_month) AS running_total_sales
FROM
	(SELECT FORMAT(order_date, 'yyyy-MM') AS order_month, SUM(sales_amount) AS total_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY FORMAT(order_date, 'yyyy-MM')) AS new_table
ORDER BY order_month
;



-- =============================
-- Product wise yearly performance and comparing with average sales values, previous years sales values of that prodcut
-- =============================
WITH yearly_performance AS (
	SELECT YEAR(order_date) AS order_year, product_name, SUM(sales_amount) AS current_sale
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	ON f.product_key = p.product_key
	WHERE order_date IS NOT NULL
	GROUP BY product_name, YEAR(order_date)

)

SELECT order_year, product_name, current_sale,
		ROUND(AVG(current_sale) OVER(PARTITION BY product_name), 0) AS avg_sale,
        (current_sale - ROUND(AVG(current_sale) OVER(PARTITION BY product_name), 0)) AS diff_avg_sale,
        CASE WHEN (current_sale - ROUND(AVG(current_sale) OVER(PARTITION BY product_name), 0)) > 0 THEN 'Above Avg'
			 WHEN (current_sale - ROUND(AVG(current_sale) OVER(PARTITION BY product_name), 0)) < 0 THEN 'Below Avg'
             ELSE 'Average'
		END AS avg_remark,
        LAG(current_sale) OVER(PARTITION BY product_name ORDER BY order_year) AS py_sale,
        (current_sale - LAG(current_sale) OVER(PARTITION BY product_name ORDER BY order_year)) AS diff_py_sale,
        CASE WHEN (current_sale - LAG(current_sale) OVER(PARTITION BY product_name ORDER BY order_year)) > 0 THEN 'Increased'
			 WHEN (current_sale - LAG(current_sale) OVER(PARTITION BY product_name ORDER BY order_year)) < 0 THEN 'Decreased'
             ELSE 'No Change'
		END AS py_remark
FROM yearly_performance
ORDER BY product_name, order_year
;




-- =============================
-- Analyze the yearly performance of products by comparing their sales
-- to both the average sales performance of the product and the previous year's sales
-- =============================
WITH yearly_product_sales AS (
    SELECT
        YEAR(f.order_date) AS order_year,
        p.product_name,
        SUM(f.sales_amount) AS current_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY
        YEAR(f.order_date),
        p.product_name
)
SELECT
    order_year,
    product_name,
    current_sales,
    AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales,
    current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
    CASE
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change,
    -- Year-over-Year Analysis
    LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS py_sales,
    current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py,
    CASE
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
        ELSE 'No Change'
    END AS py_change
FROM yearly_product_sales
ORDER BY product_name, order_year
;



-- =============================
-- Segment products into cost ranges and count how many products fall into each segment
-- =============================
WITH product_segments AS (
    SELECT
        product_key,
        product_name,
        cost,
        CASE
            WHEN cost < 100 THEN 'Below 100'
            WHEN cost BETWEEN 100 AND 500 THEN '100-500'
            WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
            ELSE 'Above 1000'
        END AS cost_range
    FROM gold.dim_products
)
SELECT
    cost_range,
    COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC
;

-- =============================
-- Group customers into three segments based on their spending behavior:
--     - VIP: Customers with at least 12 months of history and spending more than 5,000.
--     - Regular: Customers with at least 12 months of history but spending 5,000 or less.
--     - New: Customers with a lifespan less than 12 months.
-- And find the total number of customers by each group
-- =============================
WITH customer_spending AS (
    SELECT
        c.customer_key,
        SUM(f.sales_amount) AS total_spending,
        MIN(order_date) AS first_order,
        MAX(order_date) AS last_order,
        DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c
        ON f.customer_key = c.customer_key
    GROUP BY c.customer_key
)
SELECT
    customer_segment,
    COUNT(customer_key) AS total_customers
FROM (
    SELECT
        customer_key,
        CASE
            WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
            WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spending
) AS segmented_customers
GROUP BY customer_segment
ORDER BY total_customers DESC
;



-- =============================
-- Which categories contribute the most to overall sales?
-- =============================
WITH category_sales AS (
    SELECT
        p.category,
        SUM(f.sales_amount) AS total_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key
    GROUP BY p.category
)
SELECT
    category,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2) AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC
;



-- =============================================================================
-- SCRIPT 12: CUSTOMER REPORT
-- =============================================================================
-- Purpose:
--     - This report consolidates key customer metrics and behaviors.
-- Highlights:
--     1. Gathers essential fields such as names, ages, and transaction details.
--     2. Segments customers into categories (VIP, Regular, New) and age groups.
--     3. Aggregates customer-level metrics:
--        - total orders
--        - total sales
--        - total quantity purchased
--        - total products
--        - lifespan (in months)
--     4. Calculates valuable KPIs:
--        - recency (months since last order)
--        - average order value
--        - average monthly spend
-- =============================================================================

-- =============================
-- Create Report: gold.report_customers
-- =============================
IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
    DROP VIEW gold.report_customers;
GO

CREATE VIEW gold.report_customers AS

WITH base_query AS (
/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
---------------------------------------------------------------------------*/
SELECT
	f.order_number,
	f.product_key,
	f.order_date,
	f.sales_amount,
	f.quantity,
	c.customer_key,
	c.customer_number,
	CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
	DATEDIFF(year, c.birthdate, GETDATE()) AS age
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
	ON c.customer_key = f.customer_key
WHERE order_date IS NOT NULL
)

, customer_aggregation AS (
/*---------------------------------------------------------------------------
2) Customer Aggregations: Summarizes key metrics at the customer level
---------------------------------------------------------------------------*/
SELECT
	customer_key,
	customer_number,
	customer_name,
	age,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	COUNT(DISTINCT product_key) AS total_products,
	MAX(order_date) AS last_order_date,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
FROM base_query
GROUP BY
	customer_key,
	customer_number,
	customer_name,
	age
)
SELECT
customer_key,
customer_number,
customer_name,
age,
CASE
	 WHEN age < 20 THEN 'Under 20'
	 WHEN age BETWEEN 20 AND 29 THEN '20-29'
	 WHEN age BETWEEN 30 AND 39 THEN '30-39'
	 WHEN age BETWEEN 40 AND 49 THEN '40-49'
	 ELSE '50 and above'
END AS age_group,
CASE
    WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
    WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
    ELSE 'New'
END AS customer_segment,
last_order_date,
DATEDIFF(month, last_order_date, GETDATE()) AS recency,
total_orders,
total_sales,
total_quantity,
total_products,
lifespan,
-- Compute average order value (AOV)
CASE WHEN total_sales = 0 THEN 0
	 ELSE total_sales / total_orders
END AS avg_order_value,
-- Compute average monthly spend
CASE WHEN lifespan = 0 THEN total_sales
     ELSE total_sales / lifespan
END AS avg_monthly_spend
FROM customer_aggregation
;
GO



-- =============================================================================
-- SCRIPT 13: PRODUCT REPORT
-- =============================================================================
-- Purpose:
--     - This report consolidates key product metrics and behaviors.
-- Highlights:
--     1. Gathers essential fields such as product name, category, subcategory, and cost.
--     2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
--     3. Aggregates product-level metrics:
--        - total orders
--        - total sales
--        - total quantity sold
--        - total customers (unique)
--        - lifespan (in months)
--     4. Calculates valuable KPIs:
--        - recency (months since last sale)
--        - average order revenue (AOR)
--        - average monthly revenue
-- =============================================================================

-- =============================
-- Create Report: gold.report_products
-- =============================
IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL
    DROP VIEW gold.report_products;
GO

CREATE VIEW gold.report_products AS

WITH base_query AS (
/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from gold.fact_sales and gold.dim_products
---------------------------------------------------------------------------*/
    SELECT
	    f.order_number,
        f.order_date,
		f.customer_key,
        f.sales_amount,
        f.quantity,
        p.product_key,
        p.product_name,
        p.category,
        p.subcategory,
        p.cost
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON f.product_key = p.product_key
    WHERE order_date IS NOT NULL  -- only consider valid sales dates
),

product_aggregations AS (
/*---------------------------------------------------------------------------
2) Product Aggregations: Summarizes key metrics at the product level
---------------------------------------------------------------------------*/
SELECT
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
    MAX(order_date) AS last_sale_date,
    COUNT(DISTINCT order_number) AS total_orders,
	COUNT(DISTINCT customer_key) AS total_customers,
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity,
	ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)), 1) AS avg_selling_price
FROM base_query
GROUP BY
    product_key,
    product_name,
    category,
    subcategory,
    cost
)

/*---------------------------------------------------------------------------
  3) Final Query: Combines all product results into one output
---------------------------------------------------------------------------*/
SELECT
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_sale_date,
	DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_in_months,
	CASE
		WHEN total_sales > 50000 THEN 'High-Performer'
		WHEN total_sales >= 10000 THEN 'Mid-Range'
		ELSE 'Low-Performer'
	END AS product_segment,
	lifespan,
	total_orders,
	total_sales,
	total_quantity,
	total_customers,
	avg_selling_price,
	-- Average Order Revenue (AOR)
	CASE
		WHEN total_orders = 0 THEN 0
		ELSE total_sales / total_orders
	END AS avg_order_revenue,
	-- Average Monthly Revenue
	CASE
		WHEN lifespan = 0 THEN total_sales
		ELSE total_sales / lifespan
	END AS avg_monthly_revenue
FROM product_aggregations
;
GO
