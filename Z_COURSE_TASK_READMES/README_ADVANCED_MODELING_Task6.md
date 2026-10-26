# Advanced Modeling – Setup Instructions

## Overview

This part of the Online Orders & Delivery Performance project demonstrates advanced SAP HANA Calculation View features, including ranking, window functions, calculated and restricted columns, input parameters, variables, and currency conversion.

## Prerequisites

- SAP Business Application Studio
- SAP HANA Cloud database
- Configured HDI Container

## Setup

1. Open the project in SAP Business Application Studio.
2. Check the connection to the SAP HANA Cloud database and HDI Container.
3. Deploy the required tables and staging Calculation Views from `db/src`.
4. Load the demo data using the relevant SQL scripts in the `SQL` folder.
5. Deploy the advanced Calculation Views from `db/src/3. INTERMEDIATE`.
6. Open Data Preview to test the models and their measures.

## Advanced Calculation Views

- `CV_TOP_PRODUCTS_RANKED`
- `CV_SALES_WITH_ANALYTICS`
- `CV_SALES_WITH_CALCULATIONS`
- `CV_SALES_WITH_RESTRICTIONS`
- `CV_SALES_PARAMETERIZED`
- `CV_SALES_WITH_VARIABLES`
- `CV_SALES_MULTI_CURRENCY`

## Notes

- All source sales amounts are stored in EUR.
- Currency conversion uses demonstration exchange rates from the `EXCHANGE_RATES` table.
- Some Calculation Views require user selections through Input Parameters or Variables.