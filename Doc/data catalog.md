# Data Dictionary for Gold Layer
-------
#### Overview
--------
1. gold_dim_customers
   - **purpose** -: store customer data for enrchiment wtih demographic and geographic data

      | Column Name | Data Type | Column Description |
      |-------------|-----------|--------------------|
      | customer_key | INT | Surrogate key that uniquely identifies each record in the dimension table. |
      | customer_id | INT | Unique numerical identifier assigned to each customer. |
      | customer_number | VARCHAR | Alphanumeric identifier representing the customer, used for tracking and reference. |
      | first_name | VARCHAR | First name of the customer. |
      | last_name | VARCHAR | Last name of the customer. |
      | country | VARCHAR | Country of residence of the customer (e.g., 'Germany'). |
      | marital_status | VARCHAR | Marital status of the customer (e.g., 'Single', 'Married'). |
      | gender | VARCHAR | Gender of the customer (e.g., 'Male', 'Female', 'N/A'). |
      | birth_date | DATE | Customer's birth date in the format YYYY-MM-DD (e.g., '2005-05-16'). |
      | create_date | DATE | Date on which the customer record was created in the system. |
