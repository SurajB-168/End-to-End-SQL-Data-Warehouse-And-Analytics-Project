-- This script create views for final layer tables.
-- It includes data standaradization, data integration and standard naming of columns.
-- Joined different tables (Data Integration) to get the final layer.

CREATE VIEW gold.dim_customers AS
SELECT
ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
ci.cst_id AS customer_id,
ci.cst_key AS customer_number,
ci.cst_firstname AS first_name,
ci.cst_lastname AS last_name,
lc.cntry AS country,
ci.cst_marital_status AS marital_status,
CASE
	WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
	ELSE COALESCE(ca.gen, 'n/a')
END AS gender,
ca.bdate AS birthdate,
ci.cst_create_date AS create_date
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 AS lc
ON ci.cst_key = lc.cid




CREATE VIEW gold.dim_products AS
SELECT 
ROW_NUMBER() OVER(ORDER BY prd_id, prd_key) AS product_key,
pr.prd_id AS prodcut_id,
pr.prd_key AS product_number,
pr.prd_nm AS product_name,
pr.cat_id AS cateogry_id,
ca.cat AS category,
ca.subcat AS subcategory,
ca.maintenance,
pr.prd_cost AS cost,
pr.prd_line AS product_line,
pr.prd_start_dt AS start_date
FROM silver.crm_prd_info AS pr
LEFT JOIN silver.erp_px_cat_g1v2 AS ca
ON pr.cat_id = ca.id
WHERE pr.prd_end_dt IS NULL                  -- Not including the historical data




CREATE VIEW gold.fact_sales AS
SELECT
sd.sls_ord_num AS order_number,
pr.product_key,
cs.customer_key,
sd.sls_order_dt AS order_date,
sd.sls_ship_date AS shipping_date,
sd.sls_due_date AS due_date,
sd.sls_sales AS sales_amount,
sd.sls_quantity AS quantity,
sd.sls_price AS price
FROM silver.crm_sales_details AS sd
LEFT JOIN gold.dim_products AS pr
ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers AS cs
ON sd.sls_cst_id = cs.customer_id


SELECT * FROM gold.fact_sales
