-- Truncate and bulk insert (Full Load) method to insert the data in the table
-- As we need to execute this script many times, we will store this in a stored procedure
-- And we can then run this script using --> EXEC bronze.load_bronze;

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\suraj\OneDrive\Desktop\DataWarehouse Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'crm_cust_info loaded successfully';
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'seconds';



		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\suraj\OneDrive\Desktop\DataWarehouse Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'crm_prd_info loaded successfully';
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'seconds';



		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\suraj\OneDrive\Desktop\DataWarehouse Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'crm_sales_details loaded successfully';
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'seconds';



		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\suraj\OneDrive\Desktop\DataWarehouse Project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'erp_cust_az12 loaded successfully';
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'seconds';



		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\suraj\OneDrive\Desktop\DataWarehouse Project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'erp_loc_a101 loaded successfully';
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'seconds';



		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\suraj\OneDrive\Desktop\DataWarehouse Project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'erp_px_cat_g1v2 loaded successfully';
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'seconds';
		SET @batch_end_time = GETDATE();
		PRINT '============================================';
		PRINT 'BRONZE LAYER LOADED SUCCESSFULLY';
		PRINT 'Total Bronze Layer Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS VARCHAR) + 'seconds';
		PRINT '============================================';	
	END TRY

	BEGIN CATCH
		PRINT '============================================';
		PRINT 'ERROR LOADING BRONZE LAYER';
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR)
		PRINT '============================================';
	END CATCH
END


EXEC bronze.load_bronze;
