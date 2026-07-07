# Data Dictionary for Gold Layer
-------
#### Overview
--------
1. gold_dim_customers
   - **purpose** -: store customer data for enrchiment wtih demographic and geographic data


      | Column Name | Data Type | Column Description |
      |-------------|-----------|--------------------|
      | customer_key | INT | Surrogate key that uniquely identifies each record in the dimension table |
      | customer_id | INT | Unique numerical identifier assigned to each customer |
      | customer_number | VARCHAR | Alphanumeric customer identifier used for tracking |
      | first_name | VARCHAR | First name of the customer |
      | last_name | VARCHAR | Last name of the customer |
      | country | VARCHAR | Country of residence |
      | marital_status | VARCHAR | Customer marital status |
      | gender | VARCHAR | Customer gender |
      | birth_date | DATE | Birth date (YYYY-MM-DD) |
      | create_date | DATE | Record creation date |
