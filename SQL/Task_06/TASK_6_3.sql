--Verifies the calculated number of days between the order date and the actual delivery date
SELECT
    "ORDER_ID",
    "DAYS_TO_DELIVERY"
FROM "CV_SALES_WITH_CALCULATIONS"
--NULL values are excluded because orders that have not been delivered yet do not have an actual delivery date.
WHERE "DAYS_TO_DELIVERY" IS NOT NULL
ORDER BY "ORDER_ID";


--Verifyies the standardized two-letter region codes created from the original region values
SELECT DISTINCT
    "REGION_CODE"
FROM "CV_SALES_WITH_CALCULATIONS"
ORDER BY "REGION_CODE";


--Verifyies that orders are correctly grouped into Light, Medium, and Heavy weight categories
SELECT
    "WEIGHT_CATEGORY",
--Use DISTINCT prevents orders with multiple line items from being counted more than once
    COUNT(DISTINCT "ORDER_ID") AS "ORDER_COUNT"
FROM "CV_SALES_WITH_CALCULATIONS"
GROUP BY "WEIGHT_CATEGORY"
ORDER BY "WEIGHT_CATEGORY";


--Verifies the average sales value per order for each region
SELECT
    "REGION_CODE",
    "AVG_SALES_PER_ORDER"
FROM "CV_SALES_WITH_CALCULATIONS"
ORDER BY "AVG_SALES_PER_ORDER" DESC;


--Verifies the percentage of delivered orders completed on time for each carrier
--The rate is based on distinct orders to avoid counting orders with multiple line items more than once
SELECT
    "CARRIER_NAME",
    "ON_TIME_ORDER_COUNT",
    "DELIVERED_ORDER_COUNT",
    "ON_TIME_DELIVERY_RATE"
FROM "CV_SALES_WITH_CALCULATIONS"
ORDER BY "ON_TIME_DELIVERY_RATE" DESC;