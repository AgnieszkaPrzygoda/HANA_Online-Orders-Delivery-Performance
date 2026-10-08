-- Verifies that sales can be filtered by a selected year
SELECT
    "YEAR",
    "CATEGORY",
    "CALENDAR_DATE",
    SUM("AMOUNT") AS "AMOUNT"
FROM "CV_SALES_WITH_VARIABLES"
WHERE "YEAR" = 2025
GROUP BY "YEAR", "CATEGORY", "CALENDAR_DATE"
ORDER BY "CALENDAR_DATE", "CATEGORY";


-- Verifies filtering by multiple product categories
SELECT
    "YEAR",
    "CATEGORY",
    SUM("AMOUNT") AS "TOTAL_SALES"
FROM "CV_SALES_WITH_VARIABLES"
WHERE "YEAR" = 2025
  AND "CATEGORY" IN ('Electronics', 'Furniture')
GROUP BY "YEAR", "CATEGORY"
ORDER BY "CATEGORY";


-- Verifies filtering by a selected date interval
SELECT
    "YEAR",
    "CATEGORY",
    "CALENDAR_DATE",
    SUM("AMOUNT") AS "AMOUNT"
FROM "CV_SALES_WITH_VARIABLES"
WHERE "YEAR" = 2026
  AND "CALENDAR_DATE" BETWEEN '2026-01-01' AND '2026-03-31'
GROUP BY "YEAR", "CATEGORY", "CALENDAR_DATE"
ORDER BY "CALENDAR_DATE", "CATEGORY";


-- Verifies filtering by year, category and date interval together
SELECT
    "YEAR",
    "CATEGORY",
    SUM("AMOUNT") AS "TOTAL_SALES"
FROM "CV_SALES_WITH_VARIABLES"
WHERE "YEAR" = 2025
  AND "CATEGORY" = 'Electronics'
  AND "CALENDAR_DATE" BETWEEN '2025-01-01' AND '2025-06-30'
GROUP BY "YEAR", "CATEGORY";


-- Verifies the discount calculation using an Input Parameter
-- and sales filtering by year and category
SELECT
    "YEAR",
    "CATEGORY",
    "CALENDAR_DATE",
    SUM("AMOUNT") AS "TOTAL_SALES",
    SUM("CC_SALES_AFTER_DISCOUNT") AS "SALES_AFTER_DISCOUNT"
FROM "CV_SALES_WITH_VARIABLES"
    (PLACEHOLDER."$$IP_DISCOUNT_RATE$$" => '10')
WHERE "YEAR" = 2026
  AND "CATEGORY" = 'Electronics'
GROUP BY
    "YEAR",
    "CATEGORY",
    "CALENDAR_DATE"
ORDER BY "CALENDAR_DATE";