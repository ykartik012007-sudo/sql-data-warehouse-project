# Data Dictionary for Gold Layer
-------
#### Overview
--------
1. gold_dim_customers
   - **purpose** -: store customer data for enrchiment wtih demographic and geographic data

          | Column Name        | Data Type         |   Column  Description                                                                |
          -------------------------------------------------------------------------------------------------------------------------------
          | customer_key       | INT               | Surrgoate key that uniquely identify each record in the dimmesion table              |
          | customer_id        | INT               | Unique numerical identifier assign to each customer                                  |
          | customer_number    | VARCHAR           | Aphlanumerical identifier represting the customer use to tracking and reference      |
          | first_name         | VARCHAR           | First Name of each customer                                                          |
          | last_name          | VARCHAR           | last Name of each customer                                                           |
          | country            | VARCHAR           | country residence of each customer (eg . 'Germany')                                  |
          | marital_status     | VARCHAR           | marital status of customer  (eg. 'Single','Married')                                 |
          | gender             | VARCHAR           | gender fo the customer (eg. 'Male','Female','N/A')                                   |
          | birth_date         | DATE              | birthdate of customer format YYYY-MM-DD (eg.'2005-05-16')                            |
          | create_date        | DATE              | the date and time customer recorded in the system                                    |
