# Enterprise Data Management - Database / SQL

This folder contains selected coursework and the end-of-course project for the Enterprise Data Management course. The materials focus on ER/EER modeling, relational database design, SQL querying, joins, subqueries, table creation, data insertion, and business-question analysis.

Instructor slide decks whose filenames start with `EDM` are intentionally excluded from GitHub because of file size and course-material restrictions.

## Repository Structure

The original course/session folder names and filenames are preserved inside each category folder.

| Folder | Contents |
|---|---|
| `scripts/` | SQL scripts, SQLite/DB files, Draw.io source files, HTML database diagrams, and table workbooks |
| `reports/` | PDF, DOCX, and presentation/report deliverables |
| `figures/` | Exported ERD/EER images used for README preview and portfolio documentation |

## Course Content Map

| Area | Scripts | Reports | Figures |
|---|---|---|---|
| ER modeling | `scripts/Session 2_The ER model (Asynchronous session)` | `reports/Session 2_The ER model (Asynchronous session)` | `figures/Session 2_The ER model (Asynchronous session)` |
| ER/EER practice | `scripts/Session 3_The ER model in practice and the EER model in theory` | `reports/Session 3_The ER model in practice and the EER model in theory` | `figures/Session 3_The ER model in practice and the EER model in theory` |
| EER to relational model | `scripts/Session 4_The EER model and the relational model` | `reports/Session 4_The EER model and the relational model` | `figures/Session 4_The EER model and the relational model` |
| SQL basics | `scripts/Session 5_Introduction to SQL` | `reports/Session 5_Introduction to SQL` | - |
| Single-table SQL | `scripts/Session 6_Practice in SQL-one-table queries` | `reports/Session 6_Practice in SQL-one-table queries` | - |
| Joins and subqueries | `scripts/Session 7 Advanced SQL - joins` | `reports/Session 7 Advanced SQL - joins` | - |
| Table creation | `scripts/Session 8 Advanced SQL - table creation` | `reports/Session 8 Advanced SQL - table creation` | - |
| Final project | `scripts/Sessions 9-10 End-of-course project` | `reports/Sessions 9-10 End-of-course project` | - |

## Selected Diagrams

### Hospital Management ERD

![Hospital Management System ERD](<figures/Session 2_The ER model (Asynchronous session)/Hospital Management System.drawio.png>)

### ER Modeling Practice

![ER Exercise 1](<figures/Session 3_The ER model in practice and the EER model in theory/Exercise 1.drawio.png>)

![ER Exercise 2](<figures/Session 3_The ER model in practice and the EER model in theory/WenTing-Xu_Chen-He_TingYi-Kao_Exercise 2.drawio.png>)

### EER Supertype / Subtype Model

![Exercise SuperType SubType](<figures/Session 4_The EER model and the relational model/Exercise SuperType_SubType.drawio.png>)

## SQL Coursework Summary

| Topic | Representative files | Skills demonstrated |
|---|---|---|
| Basic SELECT queries | `scripts/Session 5_Introduction to SQL/newFile.sql` | Filtering, sorting, grouping, aggregate functions, and simple business summaries |
| One-table SQL practice | `scripts/Session 6_Practice in SQL-one-table queries/KAO_TINGYI_SQL.sql` | `DISTINCT`, `COUNT`, `SUM`, `GROUP BY`, `HAVING`, date filters, and top-N analysis |
| Multi-table joins | `scripts/Session 7 Advanced SQL - joins/JOIN Exercise.sql` | Inner joins, self joins, customer/invoice joins, employee-manager relationships, and track metadata queries |
| DDL and constraints | `scripts/Session 8 Advanced SQL - table creation/Create Tables Exercise.sql` and `scripts/Session 8 Advanced SQL - table creation/Exercise2.sql` | Primary keys, foreign keys, weak entities, composite keys, `CHECK` constraints, and `ALTER TABLE` |

## Final Project: GearZone Retail

The end-of-course project designs a relational database for a retail business scenario. It combines ERD design, table creation, sample data insertion, and SQL queries for business analysis.

| Component | File | Purpose |
|---|---|---|
| Project report | `reports/Sessions 9-10 End-of-course project/GEARZONE RETAIL.pdf` | Final project presentation/report |
| ERD deliverable | `reports/Sessions 9-10 End-of-course project/ERD/TingYi KAO, Wenting XU, Chen HE.pdf` | Submitted ER diagram |
| Schema design | `scripts/Sessions 9-10 End-of-course project/DB/GearZone_Tables.sql` | Creates the relational schema |
| Sample records | `scripts/Sessions 9-10 End-of-course project/DB/Data Insertion.sql` | Inserts region, vendor, category, customer, store, product, sales transaction, and sales detail data |
| Business analysis | `scripts/Sessions 9-10 End-of-course project/DB/Business Question.sql` | Combines schema, inserts, and analytical SQL queries |
| Table workbook | `scripts/Sessions 9-10 End-of-course project/DB/GearZone Tables.xlsx` | Tabular source for GearZone entities |
| Database diagram export | `scripts/Sessions 9-10 End-of-course project/DB/Gearzone.html` | HTML schema/diagram export |

### GearZone Data Model

| Entity | Main role |
|---|---|
| `Customer` | Stores customer identifiers, names, and ZIP codes |
| `Region` | Groups stores by geographic region |
| `Store` | Stores retail locations and their linked regions |
| `Vendor` | Stores product supplier information |
| `Category` | Classifies product types |
| `Product` | Stores products, prices, vendors, and categories |
| `SalesTransaction` | Records transaction headers by customer, store, and date |
| `SalesDetails` | Records transaction line items and quantities |

### Example Business Questions

| Question | SQL approach |
|---|---|
| Which stores generate the most sales revenue by region? | Join `Store`, `SalesTransaction`, `SalesDetails`, and `Product`, then aggregate `ProductQuantity * ProductUnitPrice` by region and store |
| Which customer purchased the most? | Join customers to transactions, details, and products, then aggregate total purchase value by customer |

## Upload Notes

- Do not stage or upload files whose names start with `EDM`.
- This folder includes a local `.gitignore` that excludes `EDM*` slide decks and temporary diagram backup files.
- Before committing, verify the staged file list with `git status --short`.
