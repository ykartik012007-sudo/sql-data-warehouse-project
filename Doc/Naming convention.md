# Naming Convention

## General Principle

- **Style:** `snake_case` (all letters in lowercase and separated by underscores)  
  **Example:** `customer_info`, `employee_id`
- **Language:** English
- **Avoid:** Reserved words

---

# Table Naming Conventions

## Bronze Rules

- All names must start with the source system name, and the table name will be the original table name without renaming.
- **Pattern:** `<sourcesystem>_<entity>`
  - `<sourcesystem>`: Name of the source system (e.g., `crm`, `erp`)
  - `<entity>`: Exact table name from the source system
  - **Example:** `crm_customer_info`

---

## Silver Rules

- All names must start with the source system name, and the table name will be the original table name without renaming.
- **Pattern:** `<sourcesystem>_<entity>`
  - `<sourcesystem>`: Name of the source system (e.g., `crm`, `erp`)
  - `<entity>`: Exact table name from the source system
  - **Example:** `crm_customer_info`

---

## Gold Rules

- All names must be meaningful, business-aligned names for tables starting with a category prefix.
- **Pattern:** `<category>_<entity>`
  - `<category>`: Describes the role of the table, such as `dim` (Dimension) or `fact` (Fact table)
  - `<entity>`: Descriptive name of the table aligned with the business domain (e.g., `customer`, `sales`)
  - **Examples:**
    - `dim_customers` → Dimension table for customer data
    - `fact_sales` → Fact table containing sales transactions

---

## Glossary of Category Patterns

| Pattern | Meaning | Examples |
|----------|---------|----------|
| `dim_` | Dimension table | `dim_customer`, `dim_product` |
| `fact_` | Fact table | `fact_sales` |
| `agg_` | Aggregated table | `agg_customers`, `agg_sales_monthly` |

---

# Column Naming Convention

## Surrogate Keys

- All primary keys in dimension tables must use the suffix `_key`.
- **Pattern:** `<table_name>_key`
  - `<table_name>`: Refers to the name of the table
  - `_key`: A suffix indicating that this column is a surrogate key
  - **Example:** `customer_key`

---

## Technical Columns

- All technical columns must start with the prefix `dwh_`, followed by a descriptive name indicating the column's purpose.
- **Pattern:** `dwh_<column_name>`
  - `dwh`: Prefix exclusively for system-generated metadata
  - `<column_name>`: Descriptive name indicating the column's purpose
  - **Example:** `dwh_load_date`

---

# Stored Procedures

- All stored procedures used for loading data must follow the naming pattern:
- **Pattern:** `load_<layer>`
  - `<layer>`: Represents the layer being loaded, such as `bronze`, `silver`, or `gold`
  - **Examples:**
    - `load_bronze`
    - `load_silver`
