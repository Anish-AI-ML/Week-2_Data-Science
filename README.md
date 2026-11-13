# Week 2 – Python & SQL for Data Analysis

## Source
`SQL_Sales_Dataset_200_Rows.xlsx` supplied for the SQL assignment (200 records, 10 columns).

## Python assignment
1. Load CSV with Pandas and display head, shape and info.
2. Check missing values and duplicates; remove duplicates and handle missing values if present.
3. Group by category and sum `total_price`.
4. Sort by `region` ascending and `total_price` descending.
5. Generate a correlation matrix for numerical columns.

## SQL assignment
SQLite-compatible queries cover SELECT, WHERE, GROUP BY, ORDER BY, SUM, AVG, COUNT, joins, a subquery and CASE. The sample database `week2_sales.db` is included and populated with the uploaded dataset.

## Data quality
The supplied workbook contains 200 rows, 10 columns, 0 exact duplicate rows and 0 missing cells. Therefore cleaning checks were performed, but no row needed to be removed or imputed.

## Files
- `Week2_Python_SQL_Results.xlsx`: results workbook.
- `week2_python_analysis.py`: runnable Python assignment.
- `week2_sql_queries.sql`: SQL queries.
- `week2_sales.db`: SQLite database containing the sales table.
- `SQL_Sales_Dataset_200_Rows.csv`: CSV version for Pandas/SQL import.
- `week2_summary.json`: calculated summary and SQL validation outputs.
