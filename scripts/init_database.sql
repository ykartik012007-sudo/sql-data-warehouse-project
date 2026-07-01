/*
=================================
Creating Database and Schemas
=================================

Script purpose :
  This script create a Database Named "DataWarehouse" after checking this database exist or not 
  if it's exist drop and recreate the database Additionally it's create Three Schemas 
  "bronze" , "sliver" , "gold" .

WARINING : 
  Running this script will be drop the Database if it's already exist.
  all data inside the database will be permanetly deleted .
  process with caution and ensure you have proper backup befor runnning the script.

*/

USE master 
GO

--- checking is Database exist or not, If exist drop it

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE ;
	DROP DATABASE DataWarehouse;
END;
GO

--- creating new 'Datawarehouse' database
CREATE DATABASE DataWarehouse;
GO
USE DataWarehouse;
GO

-- creating Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA sliver;
GO
CREATE SCHEMA gold;
GO
