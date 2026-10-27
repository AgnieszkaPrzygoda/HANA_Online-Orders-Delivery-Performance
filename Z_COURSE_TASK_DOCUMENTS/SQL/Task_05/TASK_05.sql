--1. "V_PERFORMANCE_MONTHLY"
-- select the periods with the higest revenue for the 'Electronics' product category
SELECT 
    ORDER_YEAR,
    ORDER_MONTH,
    PRODUCT_CATEGORY,
    TOTAL_SALES_AMOUNT,
    PERFORMANCE_STATUS
FROM "V_PERFORMANCE_MONTHLY"
WHERE PRODUCT_CATEGORY = 'Electronics' 
  AND PERFORMANCE_STATUS = 'Green'
ORDER BY ORDER_YEAR DESC, ORDER_MONTH DESC;


--Filtering by performance threshold to find areas requiring operational intervention
SELECT 
    ORDER_YEAR,
    ORDER_MONTH,
    PRODUCT_CATEGORY,
    TOTAL_SALES_AMOUNT,
    PERFORMANCE_STATUS
FROM "V_PERFORMANCE_MONTHLY"
WHERE PERFORMANCE_STATUS = 'Red'
ORDER BY TOTAL_SALES_AMOUNT ASC;


--Select the last 3 years of orders to analyze recent periods
SELECT
   ORDER_YEAR,
   ORDER_MONTH,
   PRODUCT_CATEGORY,
   TOTAL_SALES_AMOUNT,
   PERFORMANCE_STATUS
FROM "V_PERFORMANCE_MONTHLY"
WHERE ORDER_YEAR >= 2024
ORDER BY ORDER_YEAR ASC, ORDER_MONTH ASC, TOTAL_SALES_AMOUNT DESC;


--2. "V_ORDERS_DAILY_DETAILS"
--Verifying behavior for dates that are already the last day of the month
SELECT * 
FROM "V_ORDERS_DAILY_DETAILS"('2023-06-30');

--Verifying behavior for dates for a non-leap years
SELECT * 
FROM "V_ORDERS_DAILY_DETAILS"('2023-02-10');


-- 3. "V_PRODUCTS_BY_PATTERN"
-- Checking products starting with "L"
SELECT * FROM "V_PRODUCTS_BY_PATTERN"('^L');

--Checking products which have any number in their name e.g. the model number
SELECT * FROM "V_PRODUCTS_BY_PATTERN"('\d');

--Checking products taking into account small and big first letter
SELECT * FROM "V_PRODUCTS_BY_PATTERN"('(?i)monitor');


-- Bonus Task: “V_CUSTOMER_RUNNING_REVENUE"
-- Running revenue per customer sorted by order id and line item id
SELECT * FROM "V_CUSTOMER_RUNNING_REVENUE" 
ORDER BY CUSTOMER_ID, ORDER_ID, LINE_ITEM_ID;