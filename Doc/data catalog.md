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

2. gold_dim_products
   - **purpose** -: provide information about product and attribute


      | Column Name | Data Type | Column Description |
      |-------------|-----------|--------------------|
      | product_key | INT | Surrogate key that uniquely identifies each record in the dimension table. |
      | product_id | INT | Unique numerical identifier assigned to each product. |
      | product_number | VARCHAR | Alphanumeric identifier representing the product, used for tracking and reference. |
      | product_name | VARCHAR | Name of the product. |
      | category_id | VARCHAR | Unique alphabetic ID representing the category of the product. |
      | category | VARCHAR | Category of the product (e.g., 'Bikes', 'Components'). |
      | subcategory | VARCHAR | More detailed classification of the product. |
      | maintenance | VARCHAR | Indicates whether the product requires maintenance (e.g., 'Yes', 'No'). |
      | cost | INT | Cost of the product. |
      | product_line | VARCHAR | Product line to which the product belongs (e.g., 'Road', 'Mountain'). |
      | start_date | DATE | Date when the product starts to be sold. |

3. gold_dim_fact
      - **purpose** -: store transacitional sales for analytical purpose.

         | Column Name | Data Type | Column Description |
         |-------------|-----------|--------------------|
         | order_number | VARCHAR | Alphanumeric identifier for each sale. |
         | product_key | INT | Surrogate key linking the product dimension. |
         | customer_key | INT | Surrogate key linking the customer dimension. |
         | order_date | DATE | Date when the product was ordered by the customer. |
         | shipping_date | DATE | Date when the product was received by the customer. |
         | due_date | DATE | Date when the order payment was due. |
         | price | INT | Price of a single product. |
         | quantity | INT | Quantity of the product. |
         | sales | INT | Total amount of the order. |
-------




        
