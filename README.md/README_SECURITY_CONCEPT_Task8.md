
# Task 8 – Security Concepts

## Overview
This task focuses on role-based security and row-level data access in SAP HANA Cloud.
The goal was to create security artifacts, share access with a partner, and verify that permissions work correctly.

## Security Artifacts
The following artifacts were created:

- `analyst_role.hdbrole` – Provides SELECT access and includes an Analytic Privilege.
- `developer_role.hdbrole` – Defines SELECT, INSERT, UPDATE, DELETE, and EXECUTE privileges.
- `app_service_role.hdbrole` – Provides SELECT access for application services.
- `sales_region_privilege.hdbanalyticprivilege` – Restricts access to records where `REGION_CODE = 'WE'`.

The role files are stored in `db/src/roles/`, and the Analytic Privilege is stored in `db/src/privileges/`.

## Deployment and Access
All security artifacts were deployed successfully to the HDI container.
The `analyst_role` was granted to my partner's database user (`P080475`) with administrator support.
The secured Calculation View is `CV_SALES_WITH_CALCULATIONS`.

## Security Testing
Security was verified through SQL queries:

- **SELECT and COUNT:** Read access was successful.
- **GROUP BY and DISTINCT:** Only the allowed region was visible.
- **INSERT, UPDATE, CREATE TABLE:** Operations were denied with insufficient privilege errors.

## Conclusion
This task helped me understand how HDI roles and Analytic Privileges can be used to control access to data in SAP HANA Cloud.