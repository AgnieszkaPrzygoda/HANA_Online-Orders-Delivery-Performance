-- Sample INSERT statements for project documentation.
-- Based on existing data exported from SAP HANA.
-- For reference only, do not execute on populated tables

-- 1. DIM_CARRIER
-- Sample data: all 4 carriers
INSERT INTO DIM_CARRIER
    (CARRIER_ID, CARRIER_NAME, SERVICE_LEVEL)
VALUES
    (1, 'Global Express', 'Express'),
    (2, 'Speedy Logistics', 'Standard'),
    (3, 'NightCourier', 'Overnight'),
    (4, 'EcoDelivery', 'Standard');


-- 2. DIM_CUSTOMER
-- Sample data: 5 out of 25 customers
INSERT INTO DIM_CUSTOMER
    (CUSTOMER_ID, CUSTOMER_NAME, REGION, SEGMENT, LOYALTY_TIER)
VALUES
    (1, 'Acme Corp', 'North', 'Corporate', 'Silver'),
    (2, 'Global Retail', 'South', 'Retail', 'Bronze'),
    (3, 'Apex Solutions', 'East', 'VIP', 'Gold'),
    (4, 'Pioneer Inc', 'West', 'Corporate', 'Silver'),
    (5, 'Delta Trading', 'Central', 'Retail', 'Bronze');


-- 3. DIM_DATE
-- Sample data: 5 out of 47 dates
INSERT INTO DIM_DATE
    (DATE_ID, CALENDAR_DATE, YEAR, QUARTER, MONTH, DAY)
VALUES
    (20220510, '2022-05-10', 2022, 2, 5, 10),
    (20220815, '2022-08-15', 2022, 3, 8, 15),
    (20221120, '2022-11-20', 2022, 4, 11, 20),
    (20230115, '2023-01-15', 2023, 1, 1, 15),
    (20230210, '2023-02-10', 2023, 1, 2, 10);


-- 4. DIM_PRODUCT
-- Sample data: 5 out of 25 products
INSERT INTO DIM_PRODUCT
    (PRODUCT_ID, PRODUCT_NAME, CATEGORY, UNIT_PRICE, WEIGHT_KG, IS_FRAGILE, HANDLING_TYPE)
VALUES
    (1, 'Smartphone Ultra 128GB', 'Electronics', 799.99, 0.22, TRUE, 'Fragile'),
    (2, 'Wireless Bluetooth Mouse', 'Electronics', 29.99, 0.12, FALSE, 'Standard'),
    (3, 'Mechanical Gaming Keyboard', 'Electronics', 119.50, 1.10, FALSE, 'Standard'),
    (4, '4K Ultra HD Monitor 27"', 'Electronics', 349.00, 5.80, TRUE, 'Fragile'),
    (5, 'Crystal Glass Vase', 'Home & Living', 45.00, 1.40, TRUE, 'Fragile');


-- 5. FACT_ORDERS
-- Sample data: 10 out of 77 order lines
INSERT INTO FACT_ORDERS
    (ORDER_ID, LINE_ITEM_ID, DATE_ID, CUSTOMER_ID, PRODUCT_ID,
     CARRIER_ID, DELIVERY_DATE, DELIVERY_STATUS, QUANTITY,
     AMOUNT, EXPECTED_DELIVERY_DATE, CURRENCY, CUSTOMER_RATING)
VALUES
    (1, 1, 20220510, 1, 3, 2, '2022-05-15', 'Delivered', 1, 119.50, '2022-05-15', 'EUR', 2),
    (1, 2, 20220510, 1, 12, 2, '2022-05-15', 'Delivered', 1, 8.20, '2022-05-15', 'EUR', 2),
    (2, 1, 20220815, 5, 12, 1, '2022-08-20', 'Delivered', 1, 8.20, '2022-08-20', 'EUR', 3),
    (3, 1, 20221120, 12, 8, 3, '2022-11-25', 'Delivered', 2, 320.00, '2022-11-25', 'EUR', 4),
    (3, 2, 20221120, 12, 15, 3, '2022-11-25', 'Delivered', 2, 220.00, '2022-11-25', 'EUR', 4),
    (3, 3, 20221120, 12, 4, 3, '2022-11-25', 'Delivered', 1, 349.00, '2022-11-25', 'EUR', 4),
    (4, 1, 20221120, 3, 15, 2, '2022-11-24', 'Delivered', 3, 330.00, '2022-11-25', 'EUR', 5),
    (6, 1, 20230210, 7, 5, 2, '2023-02-15', 'Delivered', 1, 45.00, '2023-02-15', 'EUR', 2),
    (8, 1, 20230412, 9, 11, 1, '2023-04-15', 'Delivered', 4, 58.00, '2023-04-17', 'EUR', 4),
    (10, 1, 20230630, 4, 18, 4, '2023-07-03', 'Delivered', 3, 149.97, '2023-07-05', 'EUR', 1);