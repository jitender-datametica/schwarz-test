CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_fact_totals (
propertyid INTEGER,
fullvisitorid INTEGER,
visitid INTEGER,
date DATE,
bounces INTEGER,
pageviews INTEGER,
transactions INTEGER,
transaction_revenue BIGNUMERIC(38,10),
src_file_name STRING(16777216),
dwh_insert_ts TIMESTAMP
);