CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    date DATE,
    day_of_week VARCHAR(15),
    day_of_month INT,
    week_number INT,
    month_number INT,
    month_name VARCHAR(15),
    year INT
);

CREATE TABLE dim_product (
    product_key INT PRIMARY KEY,
    product_id VARCHAR(20),
    product_name VARCHAR(100),
    product_type VARCHAR(50),
    product_group VARCHAR(50)
);

CREATE TABLE dim_customer (
    customer_key INT PRIMARY KEY,
    customer_id VARCHAR(20),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email_address VARCHAR(100),
    adress TEXT,
    town VARCHAR(50),
    state VARCHAR(50)
);

CREATE TABLE dim_branch (
    branch_key INT PRIMARY KEY,
    branch_id VARCHAR(20),
    branch_name VARCHAR(100),
    branch_type VARCHAR(50),
    branch_size INT,
    region VARCHAR(50),
    division VARCHAR(50)
);

CREATE TABLE fact_sales_order_item (
    order_date_key INT,
    customer_key INT,
    product_key INT,
    branch_key INT,
    order_id VARCHAR(20),
    unit_price DECIMAL(15,2),
    quantity INT,
    cost DECIMAL(15,2),
    margin DECIMAL(15,2),

    PRIMARY KEY (order_date_key, customer_key, product_key, branch_key),
    FOREIGN KEY (order_date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
    FOREIGN KEY (branch_key) REFERENCES dim_branch(branch_key)
); 
