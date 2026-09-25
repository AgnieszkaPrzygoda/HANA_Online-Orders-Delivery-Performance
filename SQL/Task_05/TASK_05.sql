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