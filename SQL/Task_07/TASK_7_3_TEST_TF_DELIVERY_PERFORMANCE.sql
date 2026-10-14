-- Table Function - Reporting & Analytics
-- Test queries for TF_DELIVERY_PERFORMANCE

-- Full reporting period
-- Compare carrier performance for all available order years.
SELECT *
FROM "APRZYGODA_HANA_FINAL_PROJECT_HDI_DB_1"."TF_DELIVERY_PERFORMANCE"(
    TO_DATE('2022-01-01'),
    TO_DATE('2026-12-31')
)
ORDER BY ON_TIME_RATE DESC;


-- Single-year report
-- Compare carrier performance for orders placed in 2025.
SELECT *
FROM "APRZYGODA_HANA_FINAL_PROJECT_HDI_DB_1"."TF_DELIVERY_PERFORMANCE"(
    TO_DATE('2025-01-01'),
    TO_DATE('2025-12-31')
)
ORDER BY ON_TIME_RATE DESC;


-- Half-year report
-- Compare carrier performance for orders placed in the first half of 2026.
SELECT *
FROM "APRZYGODA_HANA_FINAL_PROJECT_HDI_DB_1"."TF_DELIVERY_PERFORMANCE"(
    TO_DATE('2026-01-01'),
    TO_DATE('2026-06-30')
)
ORDER BY ON_TIME_RATE DESC;