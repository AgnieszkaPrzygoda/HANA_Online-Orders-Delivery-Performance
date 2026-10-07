-- Verifies filtering by date range, multiple product categories and minimum sales amount
SELECT
    "CALENDAR_DATE",
    "CATEGORY",
    "AMOUNT"
FROM "CV_SALES_PARAMETERIZED"(
    PLACEHOLDER."$$IP_DATE_FROM$$" => '2025-01-01',
    PLACEHOLDER."$$IP_DATE_TO$$" => '2025-12-31',
    PLACEHOLDER."$$IP_CATEGORIES$$" => '''Electronics'',''Furniture''',
    PLACEHOLDER."$$IP_MIN_AMOUNT$$" => '100'
)
ORDER BY "CALENDAR_DATE", "CATEGORY";


-- Verifies filtering for a single product category within a shorter date range
-- IP_MIN_AMOUNT = 0 represents the default minimum threshold
SELECT
    "CALENDAR_DATE",
    "CATEGORY",
    "AMOUNT"
FROM "CV_SALES_PARAMETERIZED"(
    PLACEHOLDER."$$IP_DATE_FROM$$" => '2025-01-01',
    PLACEHOLDER."$$IP_DATE_TO$$" => '2025-03-31',
    PLACEHOLDER."$$IP_CATEGORIES$$" => '''Electronics''',
    PLACEHOLDER."$$IP_MIN_AMOUNT$$" => '0'
)
ORDER BY "CALENDAR_DATE";


-- Verifies that the minimum amount parameter filters out sales below the selected threshold
SELECT
    "CALENDAR_DATE",
    "CATEGORY",
    "AMOUNT"
FROM "CV_SALES_PARAMETERIZED"(
    PLACEHOLDER."$$IP_DATE_FROM$$" => '2025-01-01',
    PLACEHOLDER."$$IP_DATE_TO$$" => '2025-12-31',
    PLACEHOLDER."$$IP_CATEGORIES$$" => '''Electronics''',
    PLACEHOLDER."$$IP_MIN_AMOUNT$$" => '300'
)
ORDER BY "AMOUNT";


-- Verifies that IP_MIN_AMOUNT can be omitted and its default value of 0 is applied automatically
-- Aggregates sales results for the selected categories and date range
SELECT
    "CATEGORY",
    COUNT(*) AS "SALES_COUNT",
    SUM("AMOUNT") AS "TOTAL_SALES"
FROM "CV_SALES_PARAMETERIZED"(
    PLACEHOLDER."$$IP_DATE_FROM$$" => '2025-01-01',
    PLACEHOLDER."$$IP_DATE_TO$$" => '2025-12-31',
    PLACEHOLDER."$$IP_CATEGORIES$$" => '''Electronics'',''Furniture'''
)
GROUP BY "CATEGORY"
ORDER BY "TOTAL_SALES" DESC;


-- Verifies that the input parameter dynamically controls sales value classification
SELECT
    "CALENDAR_DATE",
    "CATEGORY",
    "AMOUNT",
    "SALES_VALUE_CATEGORY"
FROM "CV_SALES_PARAMETERIZED"(
    PLACEHOLDER."$$IP_DATE_FROM$$" => '2025-01-01',
    PLACEHOLDER."$$IP_DATE_TO$$" => '2025-12-31',
    PLACEHOLDER."$$IP_CATEGORIES$$" => '''Electronics'',''Furniture''',
    PLACEHOLDER."$$IP_MIN_AMOUNT$$" => '100',
    PLACEHOLDER."$$IP_HIGH_VALUE_THRESHOLD$$" => '300'
)
ORDER BY "AMOUNT";