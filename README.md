# Online Orders & Delivery Performance

## Project Overview

This SAP HANA Cloud project analyzes e-commerce orders and delivery performance. It focuses on delivery times, on-time delivery rates, carrier performance, customer satisfaction, and delivery delays.

## Technologies

- SAP HANA Cloud
- SAP Business Application Studio
- HDI Containers
- Graphical Calculation Views
- SQL and SQLScript

## Project Architecture

The main solution follows four layers:

- **DDL:** Physical tables for orders, customers, products, carriers, and dates.
- **Staging:** Base Calculation Views for fact and dimension data.
- **Intermediate:** Order-level aggregation and delivery calculations.
- **Reporting:** Delivery KPIs and carrier performance analysis.

Main reporting views:
- `CAC_R_DELIVERY_PERFORMANCE`
- `CAC_R_CARRIER_RANKING`

## SQLScript

The project also includes a scalar function, two table functions, and a stored procedure. These components demonstrate reusable calculations, carrier ranking, and delivery status updates.

## SQL Scripts and Testing

- `SQL/FINAL_PROJECT_TESTS/` – Data validation and business queries.
- `SQL/PLANVIZ_FINAL_PROJECT/` – SQL Analyzer plans and performance test queries.
- `SQL/DATA_LOAD/` – Data loading scripts.
- `SQL/Task_04` to `SQL/Task_09` – Earlier course exercises.

## Documentation

Detailed architecture, implementation, security, performance analysis, and business query results are described in the Technical Documentation.