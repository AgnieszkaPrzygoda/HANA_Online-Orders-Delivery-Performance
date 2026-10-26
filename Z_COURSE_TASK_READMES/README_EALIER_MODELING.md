# Online Orders & Delivery Performance

## 1. Business Scenario
An e-commerce company needs to monitor order fulfillment and delivery performance: track order-to-delivery time, carrier performance, on-time delivery rates, customer satisfaction/distribution by carrier, and identify logistics bottlenecks.

## 2. Project Layers & Structure
- db/src/1. DDL: Custom base table definitions (5 custom tables created from scratch)
- db/src/2. STAGING: Data cleaning and initial projections
- db/src/3. INTERMEDIATE: Business logic and intermediate joins (CAC_I_ORDERS, etc.)
- db/src/4. REPORTING: Analytical Star Schema reporting model (CAC_R_ORDERS_STAR_SCHEMA)

## 3. Data Model Architecture
- **Custom Tables & Data Population**: 5 custom base tables created via DDL and populated interactively via SQL Console during development.
- **Fact Table**: Transactional order metrics, quantities, and timestamps.
- **Dimension Tables**: Time hierarchy, customer details, carrier provider attributes, and product lookups.
- **Star Schema (CAC_R_ORDERS_STAR_SCHEMA)**: Central reporting view joining fact and dimension tables.

## 4. Key Design Notes (Dimension vs Cube Views)
- **Standalone Comparison Views**:
  - CV_PRODUCTS_DIM: Dimension view (attributes only, no automatic measure aggregation).
  - CV_PRODUCTS_CUBE: Cube view (numeric columns configured as semantic measures for BI tools like SAP Analytics Cloud / Tableau).
- **SQL Behavior Note**: In raw SQL queries (SELECT * or explicit GROUP BY), Dimension and Cube calculation views behave identically because SQL execution requires explicit projection/grouping logic. The Cube vs. Dimension distinction provides semantic metadata for BI reporting engines rather than changing raw SQL row-set behavior.

## 5. Summary of Calculation Views
- **Standalone**: CV_PRODUCTS_DIM, CV_PRODUCTS_CUBE
- **Intermediate**: CAD_I_PRODUCT, CAC_I_ORDERS, CAC_I_ORDERS_WITH_PRODUCTS, CAC_I_ORDERS_AGGREGATED, CAC_I_ORDERS_UNION
- **Reporting**: CAC_R_ORDERS_STAR_SCHEMA