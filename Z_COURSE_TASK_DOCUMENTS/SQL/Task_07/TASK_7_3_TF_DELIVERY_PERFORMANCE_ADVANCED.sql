-- Advanced Table Function Test
-- Verify carrier ranking using the RANK() window function.
-- The ranking is calculated inside TF_DELIVERY_PERFORMANCE_ADVANCED.

SELECT *
FROM "APRZYGODA_HANA_FINAL_PROJECT_HDI_DB_1"."TF_DELIVERY_PERFORMANCE_ADVANCED"(
    TO_DATE('2022-01-01'),
    TO_DATE('2026-12-31')
)
ORDER BY CARRIER_RANK;