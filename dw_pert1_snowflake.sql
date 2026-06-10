CREATE TABlE state (
    state_id INT PRIMARY KEY
);

CREATE TABlE town (
    town_id INT PRIMARY KEY,
    state_id INT,
    FOREIGN KEY (state_id) REFERENCES state(state_id)
);

CREATE TABlE customer (
    customer_id INT PRIMARY KEY,
    town_id INT,
    FOREIGN KEY (town_id) REFERENCES town(town_id)
);

CREATE TABlE division (
    division_id INT PRIMARY KEY,
    region_id INT
);

CREATE TABlE region (
    region_id INT PRIMARY KEY,
    division_id INT,
    FOREIGN KEY (division_id) REFERENCES division(division_id)
);

CREATE TABlE store (
    store_id INT PRIMARY KEY,
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES region(region_id)

);

CREATE TABlE product_group (
    product_group_id INT PRIMARY KEY,
    product_id INT
);

CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_group_id INT,
    FOREIGN KEY (product_group_id) REFERENCES product_group(product_group_id)
);

CREATE TABLE sales_order_header (
    order_id INT PRIMARY KEY,
    customer_id INT,
    store_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (store_id) REFERENCES store(store_id)
);

CREATE TABLE sales_order_detail (
    line_order_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    FOREIGN KEY (order_id) REFERENCES sales_order_header(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
); 