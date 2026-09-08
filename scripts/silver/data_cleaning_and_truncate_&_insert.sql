-- Data cleaning and inserting data to silver layer


CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY
		SET @start_time = GETDATE();
		SET @batch_start_time = GETDATE();
		TRUNCATE TABLE silver.crm_cust_info;
		INSERT INTO silver.crm_cust_info(
		cst_id,
		cst_key,
		cst_firstname,
		cst_lastname,
		cst_marital_status,
		cst_gndr,
		cst_create_date
		)
		SELECT 
		cust_id,
		cst_key,
		TRIM(cst_firstname) AS cst_firstname,
		TRIM(cst_lastname) AS cst_lastname,
		CASE 
			WHEN TRIM(UPPER(cst_marital_status)) = 'M' THEN 'Married'
			WHEN TRIM(UPPER(cst_marital_status)) = 'S' THEN 'Single'
			ELSE 'n/a'
		END AS cst_marital_status,
		CASE 
			WHEN TRIM(UPPER(cst_gndr)) = 'M' THEN 'Male'
			WHEN TRIM(UPPER(cst_gndr)) = 'F' THEN 'Female'
			ELSE 'n/a'
		END AS cst_gndr,
		cst_create_date
		FROM
			(SELECT *, ROW_NUMBER() OVER(PARTITION BY cust_id ORDER BY cst_create_date DESC) AS flag_check
			FROM bronze.crm_cust_info
			WHERE cust_id IS NOT NULL) AS new
		WHERE flag_check = 1;
		SET @end_time = GETDATE();
		PRINT 'silver.crm_cust_info truncated and inserted successfully'
		PRINT '>> Time taken to load the table: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'seconds'
		


		SET @start_time = GETDATE();
		TRUNCATE TABLE silver.crm_prd_info;
		INSERT INTO silver.crm_prd_info(
		prd_id,
		cat_id,
		prd_key,
		prd_nm,
		prd_cost,
		prd_line,
		prd_start_dt,
		prd_end_dt
		)
		SELECT
		prd_id,
		REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
		SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,
		prd_nm,
		ISNULL(prd_cost, 0) AS prd_cost,
		CASE
			WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
			WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
			WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
			WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
			ELSE 'n/a'
		END AS prd_line,
		prd_start_dt,
		DATEADD(DAY, -1, LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)) AS prd_end_dt
		FROM bronze.crm_prd_info;
		SET @end_time = GETDATE();
		PRINT 'silver.crm_prd_info truncated and inserted successfully'
		PRINT '>> Time taken to load the table: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'seconds'
		


		SET @start_time = GETDATE();
		TRUNCATE TABLE silver.crm_sales_details;
		INSERT INTO silver.crm_sales_details(
		sls_ord_num,
		sls_prd_key,
		sls_cst_id,
		sls_order_dt,
		sls_ship_date,
		sls_due_date,
		sls_sales,
		sls_quantity,
		sls_price
		)
		SELECT
		sls_ord_num,
		sls_prd_key,
		sls_cst_id,
		CASE
			WHEN sls_order_dt <= 0 OR LEN(sls_order_dt)!= 8 THEN NULL
			ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
		END AS sls_order_dt,
		CASE
			WHEN sls_ship_date <= 0 OR LEN(sls_ship_date)!= 8 THEN NULL
			ELSE CAST(CAST(sls_ship_date AS VARCHAR) AS DATE)
		END AS sls_ship_date,
		CASE
			WHEN sls_due_date <= 0 OR LEN(sls_due_date)!= 8 THEN NULL
			ELSE CAST(CAST(sls_due_date AS VARCHAR) AS DATE)
		END AS sls_due_date,
		CASE
			WHEN sls_sales IS NULL OR sls_sales != ABS(sls_price)*sls_quantity THEN ABS(sls_price) * sls_quantity
			ELSE sls_sales
		END AS sls_sales,
		sls_quantity,
		CASE
			WHEN sls_price IS NULL OR sls_price <= 0 THEN sls_sales/NULLIF(sls_quantity, 0)
			ELSE sls_price
		END AS sls_price
		FROM bronze.crm_sales_details;
		SET @end_time = GETDATE()
		PRINT 'silver.crm_sales_details truncated and inserted successfully'
		PRINT '>> Time taken to load the table: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'seconds'
		



		SET @start_time = GETDATE()
		TRUNCATE TABLE silver.erp_cust_az12;
		INSERT INTO silver.erp_cust_az12(
		cid,
		bdate,
		gen
		)
		SELECT
		CASE
			WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
			ELSE cid
		END AS cid,
		CASE
			WHEN bdate > GETDATE() THEN NULL
			ELSE bdate
		END AS bdate,
		CASE
			WHEN TRIM(UPPER(gen)) = 'F' THEN 'Female'
			WHEN TRIM(UPPER(gen)) = 'M' THEN 'Male'
			WHEN gen is NULL OR TRIM(gen) = '' THEN 'n/a'
			ELSE gen
		END AS gen
		FROM bronze.erp_cust_az12;
		SET @end_time = GETDATE();
		PRINT 'silver.erp-cust_az12 truncated and inserted successfully'
		PRINT '>> Time taken to load the table: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'seconds'
		


		SET @start_time = GETDATE();
		TRUNCATE TABLE silver.erp_loc_a101;
		INSERT INTO silver.erp_loc_a101(
		cid,
		cntry
		)
		SELECT
		REPLACE(cid, '-', '') AS cid,
		CASE
		 WHEN UPPER(TRIM(cntry)) IN ('US', 'USA') THEN 'United States'
		 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
		 WHEN UPPER(TRIM(cntry)) = 'DE' THEN 'Germany'
		 ELSE TRIM(cntry)
		END AS cntry
		FROM bronze.erp_loc_a101;
		SET @end_time = GETDATE();
		PRINT 'silver.erp_loc_a101 truncated and inserted successfully'
		PRINT '>> Time taken to load the table: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'seconds'
		



		SET @start_time = GETDATE();
		TRUNCATE TABLE silver.erp_px_cat_g1v2;
		INSERT INTO silver.erp_px_cat_g1v2(
		id,
		cat,
		subcat,
		maintenance
		)
		SELECT
		id,
		cat,
		subcat,
		maintenance
		FROM bronze.erp_px_cat_g1v2
		SET @end_time = GETDATE();
		SET @batch_end_time = GETDATE();
		PRINT 'silver.erp_px_cat_g1v2 truncated and inserted successfully'
		PRINT '>> Time taken to load the table: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'seconds'
		

		PRINT '======================='
		PRINT 'Silver layer loaded successfully'
		PRINT '>> Total time taken to load the layer: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS VARCHAR) + 'seconds'
		PRINT '======================='

	END TRY
	BEGIN CATCH
		PRINT 'ERROR LOADING SILVER LAYER'
		PRINT 'Error message: ' + ERROR_MESSAGE()
		PRINT 'Error number: ' + CAST(ERROR_NUMBER() AS VARCHAR)
		PRINT 'Error state: ' + CAST(ERROR_STATE() AS VARCHAR)
	END CATCH

END


EXEC silver.load_silver;
