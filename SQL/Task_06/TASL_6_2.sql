-- Verifies monthly sales trends and period-over-period metrics for Electronics in 2025
-- Electronics has continuous monthly sales data in 2025, so the 3-period moving average
-- and previous-period comparison represent standard calendar month-based calculations
-- RUNNING_TOTAL accumulates sales across the full available history of each category
-- and does not reset at the beginning of each year
SELECT
    "YEAR",
    "MONTH",
    "MONTHLY_SALES",
    "RUNNING_TOTAL",
    "MOVING_AVG_3M",
    "PREVIOUS_MONTH_SALES",
    "MOM_CHANGE",
    "MOM_CHANGE_PCT"
FROM "CV_SALES_WITH_ANALYTICS"
WHERE "CATEGORY" = 'Electronics'
  AND "YEAR" = 2025
ORDER BY "MONTH";


-- Verifies how monthly category sales results are ranked within 2025
-- SALES_RANK compares all category-month sales results within the same year
SELECT
    "CATEGORY",
    "MONTH",
    "MONTHLY_SALES",
    "SALES_RANK"
FROM "CV_SALES_WITH_ANALYTICS"
WHERE "YEAR" = 2025
ORDER BY "SALES_RANK";


-- Finds the strongest positive sales changes compared with the preceding available period
-- For categories with continuous monthly data, this represents a standard month-over-month change
SELECT
    "CATEGORY",
    "YEAR",
    "MONTH",
    "MONTHLY_SALES",
    "PREVIOUS_MONTH_SALES",
    "MOM_CHANGE",
    "MOM_CHANGE_PCT"
FROM "CV_SALES_WITH_ANALYTICS"
WHERE "MOM_CHANGE_PCT" > 0
ORDER BY "MOM_CHANGE_PCT" DESC
LIMIT 10;


-- Verifies that the cumulative sales value at the end of each category's available history
-- equals the total sales calculated for that category
SELECT
    "CATEGORY",
    MAX("RUNNING_TOTAL") AS "FINAL_RUNNING_TOTAL",
    SUM("MONTHLY_SALES") AS "CALCULATED_TOTAL"
FROM "CV_SALES_WITH_ANALYTICS"
GROUP BY "CATEGORY"
ORDER BY "CATEGORY";