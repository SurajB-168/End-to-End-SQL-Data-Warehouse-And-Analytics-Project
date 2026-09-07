-- =================================
-- Quality checks in bronze.crm_cust_info
-- =================================

SELECT *
FROM bronze.crm_cust_info;

-- To check duplicates and nulls in the primary key
SELECT cust_id, COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cust_id
HAVING COUNT(*) > 1 OR cust_id IS NULL;


-- Check for unwanted spaces in each column
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);


-- Data Standardization (Conventional naming)
SELECT DISTINCT(cst_marital_status)
FROM bronze.crm_cust_info;



-- =================================
-- Quality checks in bronze.crm_cust_info
-- =================================

SELECT *
FROM bronze.crm_prd_info;

-- Divide the prd_key into 2 columns 1) first 5 characters are category id 2) rest characters are prd_key

-- Check for extra spaces in product name
SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);
-- So no extra spaces in the column

-- Check for negative costs and NULLs in the product cost
SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;
-- 2 NULLS (We can replace them with 0 if business allows it)


-- Checking distinct values of product line
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info;


-- Check whether the end date is later than the start date
SELECT prd_key, prd_start_dt, prd_end_dt
FROM bronze.crm_prd_info
WHERE prd_start_dt > prd_end_dt;




-- =================================
-- Quality checks in bronze.crm_sales_details
-- =================================

SELECT * FROM bronze.crm_sales_details;


-- Check for trimming issues (so there wont be any problem while connecting the tables)
SELECT *
FROM bronze.crm_sales_details
WHERE sls_ord_num != TRIM(sls_ord_num) OR sls_prd_key != TRIM(sls_prd_key)


-- Check whether all the product keys and customer id are present in both the tables that we are going to connect
SELECT *
FROM bronze.crm_sales_details
WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info) OR sls_cst_id NOT IN (SELECT cust_id FROM silver.crm_cust_info)


-- Date columns are not standardized, so first check for invalid dates
SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0
OR LEN(sls_order_dt) != 8
OR sls_ship_date <= 0
OR LEN(sls_ship_date) != 8
OR sls_due_date <= 0
OR LEN(sls_due_date) != 8


-- Check if the order date is later than the shipping date or due date
SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_date OR sls_order_dt > sls_due_date


-- Check if the data follows this: sales = quantity * price
SELECT *
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity*sls_price
-- From this we can tell there are negative prices in the data, so first let check the price

-- Check for invalid prices, quantity
SELECT sls_price, sls_quantity
FROM bronze.crm_sales_details
WHERE sls_price <= 0 OR sls_quantity <= 0




-- =================================
-- Quality checks in bronze.erp_cust-az12
-- =================================

SELECT * FROM bronze.erp_cust_az12;

-- Check for invalid dates (Birth date from the future)
SELECT bdate
FROM bronze.erp_cust_az12
WHERE bdate > GETDATE()

-- Check for standardization of gen
SELECT DISTINCT gen
FROM bronze.erp_cust_az12;




-- =================================
-- Quality checks in bronze.erp_loc_a101
-- =================================

SELECT * FROM bronze.erp_loc_a101;

-- Remove the hyphen from the cid as we have to connect this table with other tables using cid
SELECT REPLACE(cid, '-', '') AS cid
FROM bronze.erp_loc_a101;


-- Check standardization of country names
SELECT DISTINCT cntry
FROM bronze.erp_loc_a101


-- Check for extra spaces
SELECT cntry
FROM bronze.erp_loc_a101
WHERE TRIM(cntry) != cntry





-- =================================
-- Quality checks in bronze.erp_px_cat_g1v2
-- =================================

SELECT * FROM bronze.erp_px_cat_g1v2;

-- No cleaning needed
