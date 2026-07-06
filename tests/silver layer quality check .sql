/*
=======================================================================
      QUALITY CHECKS   |
========================
    Script purpose - : 
        this is script is used to check quality of data for silver layer
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
*/

/*
====================================
	         CRM TABLE 
====================================
  table : crm_cust_info
 ------------------------
*/
--checking null and primarykey duplication
SELECT 
	cst_id,
	COUNT(*)
FROM sliver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

--checking unwanted space
SELECT 
	*
FROM sliver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

--checking data consistency 
SELECT DISTINCT
	cst_marital_status
FROM sliver.crm_cust_info

/*
-------------------------
  table :crm_prd_info
-------------------------
*/
  
  -- Duplication and Null check of Primary key

SELECT 
	prd_id,
	COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Checking Unwanted space
SELECT 
	*
FROM silver.crm_prd_info
WHERE prd_line != TRIM(prd_line)

--Checking cost value is less than zero and null
SELECT *
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

--Checking stanadarization 
SELECT DISTINCT
	prd_line
FROM silver.crm_prd_info

--Validating datetime
SELECT 
	* 
FROM silver.crm_prd_info
WHERE prd_start_dt > prd_end_dt

/*
----------------------------
 table : crm_sales_details
 ---------------------------
*/
--Checking all Forgein key exist in sales tables
SELECT 
	sls_cust_id
FROM silver.crm_sales_details
WHERE sls_cust_id NOT IN (SELECT cst_id FROM silver.crm_cust_info)

--Checking isdate or not
SELECT 
	sls_due_dt 
FROM silver.crm_sales_details
WHERE sls_due_dt <= 0
OR LEN(sls_due_dt) != 8

--Checking date validation
SELECT 
	*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
OR sls_order_dt > sls_due_dt

--Checking sales , quanitity and price validation
SELECT 
	sls_sales,
	sls_quantity,
	sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales <= 0 OR sls_sales IS NULL
OR sls_quantity <=0 OR sls_quantity IS NULL
OR sls_price <=0 OR sls_price IS NULL
ORDER BY sls_sales,sls_quantity,sls_price

/*
====================================
	         ERP TABLE 
====================================
-------------------------
 table : erp_cust_az12
-------------------------
*/
--Checking duplication and null
SELECT 
	cid,
	COUNT(*)
FROM silver.erp_cust_az12
GROUP BY cid
HAVING COUNT(*) > 1 OR cid IS NULL

--Checking key connectivity
SELECT 
	cid
FROM silver.erp_cust_az12
WHERE cid NOT IN (SELECT cst_key FROM silver.crm_cust_info)

--checking is bdate is valid
SELECT DISTINCT
	bdate 
FROM silver.erp_cust_az12
WHERE bdate > GETDATE()


--checking gen Standarlization
SELECT DISTINCT
	gen
FROM silver.erp_cust_az12

/*
------------------------
  table : erp_loc_a101
------------------------
*/

-- checking table connectivity
SELECT 
	cid
FROM silver.erp_loc_a101
WHERE cid NOT IN (SELECT cst_key FROM silver.crm_cust_info)

--checking Consistency
SELECT DISTINCT
	cntry
FROM silver.erp_loc_a101

/*
----------------------------
 table : erp_px_cat_g1v2
 ---------------------------
*/
--Checking connectivity
SELECT 
	 id
FROM bronze.erp_px_cat_g1v2
WHERE id  NOT IN (SELECT cat_id FROM silver.crm_prd_info)

--Checking consistency
SELECT DISTINCT
	cat
FROM bronze.erp_px_cat_g1v2




