CREATE OR REPLACE TABLE smp_production_insights.dim_date_2 (
date_actual DATE,
date_year INTEGER,
date_month INTEGER,
date_day_of_month INTEGER,
date_quarter INTEGER,
month_name STRING(16777216),
day_name STRING(16777216),
is_weekend BOOL
);