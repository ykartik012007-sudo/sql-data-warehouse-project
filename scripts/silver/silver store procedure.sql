/*
==========================================================
             SILVER LAYER STORE PROCEDURE
==========================================================
Script Purpose :- 
          This store procedure load data from bronze layer to 
          silver layer after cleansing 
Filtering - :
      - handling Null and duplication Primary key
      - removing unwanted space
      - data normalization 
      - invalid date range and orders
      - data consitency between realted coloumn

use note -:
      - Check all this filter before execute this store procedure
      - investigate any new issue is occuring or not  
        if it's occure reslove it then execute this store procedure 
        
Parameter : this store procedure doesn't accept any paramater

Using Example
	EXCE silver.load_bronze;

  */
--Creating Store procedure to load data from bronze layer to silver layer after cleansing
CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	
	DECLARE @silver_start_time DATETIME2,@silver_end_time DATETIME2; 
	DECLARE @start_time DATETIME2,@end_time DATETIME2

	--Intilizating the variable silver_start_time to calucate load duration of the silver layer
	SET @silver_start_time = GETDATE();
	
	-- Error handling
	BEGIN TRY 
		PRINT '========================================';
		PRINT '        LOADING SILVER LAYER';
		PRINT '========================================';

		--Source = crm
		PRINT '----------------------------------------';
		PRINT '        LOADING CRM TABLE';
		PRINT '----------------------------------------';

		-- truncating table (silver.crm_cust_info) then inserting data into it from bronze layer after cleansing
		PRINT '>> Truncating table : silver.crm_cust_info';
		TRUNCATE TABLE silver.crm_cust_info;
		PRINT '>> Inserting  table : silver.crm_cust_info';

		--Intilizating variable start_time with current time to calucate load duration of the table
		SET @start_time = GETDATE();
		INSERT INTO silver.crm_cust_info
		(
			cst_id,
			cst_key,
			cst_firstname,
			cst_lastname,
			cst_marital_status,
			cst_gndr,
			cst_create_date
		)
		SELECT 
			cst_id,
			cst_key,
			TRIM(cst_firstname) cst_firstname,
			TRIM(cst_lastname) cst_lastname,
			CASE
				WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
				WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
				ELSE 'N/A'
			END cst_marital_status --Normalize marital status value to readable format 
			,
			CASE
				WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
				WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
				ELSE 'N/A'
			END AS cst_gndr,
			cst_create_date --Normalize Gender value to readable format
		FROM
		(
		SELECT 
		ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) flag_last,
		*
		FROM bronze.crm_cust_info
		WHERE cst_id IS NOT NULL
		) t WHERE  flag_last = 1 -- It's check duplication of Primary key

		--Intilizating variable end_time with current time to calucate load duration of the table
		SET @end_time = GETDATE();
		PRINT '>>Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR(50)) + ' Sec'

		-- truncating table (silver.crm_prd_info) then inserting data into it from bronze layer after cleansing
		PRINT '--------------';
		PRINT '>> Truncating table : silver.crm_prd_info';
		TRUNCATE TABLE silver.crm_prd_info;
		PRINT '>> Inserting table : silver.crm_prd_info';

		--Intilizating variable start_time with current time to calucate load duration of the table
		SET @start_time = GETDATE();

		INSERT INTO silver.crm_prd_info
		(
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
			REPLACE(SUBSTRING(prd_key,1,5),'-','_') cat_id, --Extract category from prd_key 
			SUBSTRING(prd_key,7,len(prd_key)) prd_key, --Extract prdouct key from prd_key
			prd_nm,
			ISNULL(prd_cost,0) prd_cost,
			CASE WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
				 WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
				 WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
				 WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
				ELSE 'N/A'
			END prd_line, --Normalized prd_line 
			CAST(prd_start_dt AS DATE) prd_start_dt,
			CAST(DATEADD(DAY,-1,LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)) AS DATE)prd_end_dt --Calculate end date by 1 day before the start date
		FROM bronze.crm_prd_info
		
		--Intilizating variable end_time with current time to calucate load duration of the table
		SET @end_time = GETDATE();
		PRINT 'Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR(50)) + ' Sec'

		-- truncating table (silver.crm_sales_details) then inserting data into it from bronze layer after cleansing
		PRINT '--------------';
		PRINT '>> Truncating table : silver.crm_sales_details';
		TRUNCATE TABLE silver.crm_sales_details
		PRINT '>> Inserting table : silver.crm_sales_details';

		--Intilizating variable start_time with current time to calucate load duration of the table
		SET @start_time = GETDATE();

		INSERT INTO silver.crm_sales_details
		(
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		sls_order_dt,
		sls_ship_dt,
		sls_due_dt,
		sls_sales,
		sls_quantity,
		sls_price
		)
		SELECT 
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			CASE
				WHEN LEN(sls_order_dt) != 8 OR sls_order_dt <= 0 THEN NULL
				ELSE TRY_CONVERT(Date,CAST(sls_order_dt AS VARCHAR(8))) 
			END sls_order_dt, --checking the value is date and convert datatype INT to DATE
			CASE
				WHEN LEN(sls_ship_dt) != 8 OR sls_ship_dt <= 0 THEN NULL
				ELSE TRY_CONVERT(Date,CAST(sls_ship_dt AS VARCHAR(8)))
			END sls_ship_dt,--checking the value is date and convert datatype INT to DATE
			CASE
				WHEN LEN(sls_due_dt) != 8 OR sls_due_dt <= 0 THEN NULL
				ELSE TRY_CONVERT(Date,CAST(sls_due_dt AS VARCHAR(8)))
			END sls_due_dt,--checking the value is date and convert datatype INT to DATE
	
			CASE 
				WHEN sls_sales <= 0 OR sls_sales IS NULL
				  OR sls_sales != sls_quantity * ABS(sls_price)
				THEN sls_quantity * ABS(sls_price)
				ELSE sls_sales 
			END sls_sales,--checking if sales value is 0 and negative or miss calculation then recalculate with "sls_quantity * ABS(sls_price)"
			sls_quantity,
			CASE
				WHEN sls_price <= 0 OR sls_price IS NULL THEN (sls_sales/NULLIF(sls_quantity,0))
				ELSE sls_price
			END sls_price --checking if sales value is 0 and negative or miss calculation then recalculate with "sls_sales/NULLIF(sls_quantity,0)"
		FROM bronze.crm_sales_details

		--Intilizating variable end_time with current time to calucate load duration of the table
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR(50)) + ' Sec'

		--Source = erp
		PRINT '----------------------------------------';
		PRINT '        LOADING ERP TABLE';
		PRINT '----------------------------------------';

		-- truncating table (silver.erp_cust_az12) then inserting data into it from bronze layer after cleansing
		PRINT '>> Truncating table : silver.erp_cust_az12';
		TRUNCATE TABLE silver.erp_cust_az12
		PRINT '>> Inserting table : silver.erp_cust_az12';

		--Intilizating variable start_time with current time to calucate load duration of the table
		SET @start_time = GETDATE();

		INSERT INTO silver.erp_cust_az12
		(
		cid,
		bdate,
		gen
		)
		SELECT 
			CASE
				WHEN TRIM(cid) LIKE 'NAS%' THEN SUBSTRING(cid,4,len(cid))
				ELSE cid
			END cid, --Extract id according to crm_cust_id
			CASE 
				WHEN bdate >= GETDATE() THEN  NULL
				ELSE bdate
			END bdate, --Checking bdate is valid or invalid  
			CASE 
				WHEN TRIM(UPPER(gen)) IN ('M','MALE')  THEN 'Male'
				WHEN TRIM(UPPER(gen)) IN ('F','FEMALE')  THEN 'Female'
				ELSE 'N/A' 
			END gen --Normalization the gender
		FROM bronze.erp_cust_az12

		--Intilizating variable end_time with current time to calucate load duration of the table
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR(50)) + ' Sec'

		-- truncating table (silver.erp_loc_a101) then inserting data into it from bronze layer after cleansing
		PRINT '--------------';
		PRINT '>> Truncating table : silver.erp_loc_a101';
		TRUNCATE TABLE silver.erp_loc_a101
		PRINT '>> Inserting table : silver.erp_loc_a101';

		--Intilizating variable start_time with current time to calucate load duration of the table
		SET @start_time = GETDATE();

		INSERT INTO silver.erp_loc_a101
		(
		cid,
		cntry
		)
		SELECT 
			REPLACE(cid,'-','') cid,
			CASE 
				WHEN cntry LIKE 'DE' THEN 'Germany'
				WHEN cntry IN ('USA','US') THEN 'United States'
				WHEN cntry = ' ' OR cntry IS NULL THEN 'N/A'
				ELSE cntry
			END cntry
		FROM bronze.erp_loc_a101

		--Intilizating variable end_time with current time to calucate load duration of the table
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR(50)) + ' Sec'

		-- truncating table (silver.erp_px_cat_g1v2) then inserting data into it from bronze layer after cleansing
		PRINT '--------------';
		PRINT '>> Truncating table : silver.erp_px_cat_g1v2';
		TRUNCATE TABLE silver.erp_px_cat_g1v2
		PRINT '>> Inserting table : silver.erp_px_cat_g1v2';
		
		--Intilizating variable start_time with current time to calucate load duration of the table
		SET @start_time = GETDATE();

		INSERT INTO silver.erp_px_cat_g1v2
		(
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

		--Intilizating variable end_time with current time to calucate load duration of the table
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR(50)) + ' Sec';

		--Intilizating the variable end_time to calculate load duration of the silver layer
		SET @silver_end_time = GETDATE();

		PRINT '========================================';
		PRINT ' LODING SILVER LAYER IS COMPLETED';
		PRINT ' Batch Duration : ' + CAST(DATEDIFF(SECOND,@silver_start_time,@silver_end_time) AS NVARCHAR(50)) + ' Sec';
		PRINT '========================================';
	END TRY

	--Catching error 
	BEGIN CATCH
		PRINT '===============================================';
		PRINT ' AN ERROR OCCURRED DURING BRONZE LAYER LOADING'
		PRINT ' ERROR MESSAGE : ' + ERROR_MESSAGE()
		PRINT ' ERROR NUMBER  : ' + CAST(ERROR_NUMBER() AS NVARCHAR)
		PRINT ' ERROR STATE  : ' + CAST(ERROR_STATE() AS NVARCHAR)
		PRINT '================================================';
 	END CATCH
END;
