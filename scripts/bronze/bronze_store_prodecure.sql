/*
==============================================================================================
                     Bronze Layer Store Procedure
===============================================================================================
Script purpose : 
    This store producre store data into bronze Layer of  data warehouse from external CSV file 
    This script perform following task
  - it's truncate the table before loading data
  - it's load data into table using  " BULK INSERT " command

Parameter : this store procedure doesn't accept any paramater

Using Example
	EXCE bronze.load_bronze;
 ============================================================================================== 
*/

--Creating Store procedure for bronze layer
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @bronze_start_time DATETIME, @bronze_end_time DATETIME;
	DECLARE @start_time DATETIME, @end_time DATETIME

	--Intilizating the variable start_time to calucate load duration of the bronze layer
	SET @bronze_start_time = GETDATE();
	-- Error handling
	BEGIN TRY
		PRINT '=====================================';
		PRINT '     LOADING BRONZE LAYER';
		PRINT '=====================================';

		--Source = crm
		PRINT '-------------------------------------';
		PRINT '          LOADING CRM TABLE';
		PRINT '-------------------------------------';

		-- truncating table (bronze.crm_cust_info) then inserting data into it from source (cust_Info.csv)
		
		PRINT '>> Truncating    : bronze.crm_cust_info';
		PRINT '>> Inserting     : bronze.crm_cust_info';
		
		--Intilizating variable start_time with current time to calucate load duration of the table
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Raizen\Documents\SQL DATA WITH BARA\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		--Intilizating variable end_time with current time to calucate load duration of the table
		SET @end_time = GETDATE()
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND,@end_time,@start_time) AS NVARCHAR) + ' seconds';
		PRINT '--------------'

		-- truncating table (bronze.crm_prd_info) then inserting data into it from source (prd_info.csv)
		PRINT '>> Truncating : bronze.crm_prd_info';
		PRINT '>> Inserting  : bronze.crm_prd_info';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Raizen\Documents\SQL DATA WITH BARA\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		--Intilizating variable end_time with current time to calucate load duration of  the table
		SET @end_time = GETDATE()
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '--------------'

		-- truncating table (bronze.crm_sales_details) then inserting data into it from source (sales_details.csv)
		PRINT '>> Truncating : bronze.crm_sales_details';
		PRINT '>> Inserting  : bronze.crm_sales_details';

		--Intilizating variable start_time with current time to calucate load duration of the table 
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Raizen\Documents\SQL DATA WITH BARA\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		--Intilizating variable end_time with current time to calucate load duration of  the table
		SET @end_time = GETDATE()
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '--------------'

		--Source = erp
		PRINT '-------------------------------------';
		PRINT '          LOADING ERP TABLES ';
		PRINT '-------------------------------------';

		-- truncating table (bronze.erp_cust_az12) then inserting data into it from source (CUST_AZ12.csv)
		PRINT '>> Truncating : bronze.erp_cust_az12';
		PRINT '>> Inserting  : bronze.erp_cust_az12';

		--Intilizating variable start_time with current time to calcuate load duration of the table 
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Raizen\Documents\SQL DATA WITH BARA\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		--Intilizating variable end_time with current time to calucate load duration of  the table
		SET @end_time = GETDATE()
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '--------------'

		-- truncating table (bronze.erp_loc_a101) then inserting data into it from source (LOC_A10.csv)
		PRINT '>> Truncating : bronze.erp_loc_a101';
		PRINT '>> Inserting  : bronze.erp_loc_a101';

		--Intilizating variable start_time with current time to calucate load duration of the table
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Raizen\Documents\SQL DATA WITH BARA\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		--Intilizating variable end_time with current time to calucate load duration of  the table
		SET @end_time = GETDATE()
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '--------------'

		-- truncating table (bronze.erp_px_cat_g1v2) then inserting data into it from source (PX_CAT_G1V2.csv)
		PRINT '>> Truncating : bronze.erp_px_cat_g1v2';
		PRINT '>> Inserting  : bronze.erp_px_cat_g1v2';

		--Intilizating variable start_time with current time to calucate load duration of the table 
		SET @start_time = GETDATE()
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Raizen\Documents\SQL DATA WITH BARA\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		--Intilizating variable end_time with current time to calucate load duration of  the table
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '--------------';

		--Intilizating the variable end_time to calculate load duration of the bronze layer
		SET @bronze_end_time = GETDATE();
		PRINT '==============================================='
		PRINT 'LOADING BRONZE LAYER IS COMPLETED'
		PRINT 'Bronze layer duration  : ' + CAST(DATEDIFF(SECOND,@bronze_start_time,@bronze_end_time) AS NVARCHAR) + ' seconds';
		PRINT '==============================================='
	END TRY

	--Catching error 
	BEGIN CATCH
	PRINT '=============================================';
	PRINT ' AN ERROR OCCURRED DURING BRONZE LAYER LOADING';
	PRINT ' Error message : ' + ERROR_MESSAGE();
	PRINT ' Error Number  : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT ' Error State   : ' + CAST(ERROR_STATE() AS NVARCHAR);
	PRINT '=============================================';
	END CATCH
END
