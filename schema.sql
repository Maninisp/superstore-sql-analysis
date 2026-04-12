CREATE TABLE superstore (
    row_id        INT,
    order_id      VARCHAR(20),
    order_date    DATE,
    ship_date     DATE,
    ship_mode     VARCHAR(30),
    customer_id   VARCHAR(20),
    customer_name VARCHAR(100),
    segment       VARCHAR(30),
    country       VARCHAR(50),
    city          VARCHAR(50),
    state        VARCHAR(50),
    postal_code   VARCHAR(20),
    region        VARCHAR(20),
    product_id    VARCHAR(20),
    category      VARCHAR(50),
    sub_category  VARCHAR(50),
    product_name  VARCHAR(200),
    sales         NUMERIC(10,2),
    quantity      INT,
    discount      NUMERIC(4,2),
    profit        NUMERIC(10,2)
);


