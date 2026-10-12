CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_fact_hits_2 (
propertyid INTEGER,
fullvisitorid INTEGER,
hitnumber INTEGER,
custdimindex STRING(16777216),
custdimvalue STRING(16777216),
pagepath STRING(16777216),
pagetitle STRING(16777216),
src_file_name STRING(16777216),
dwh_insert_ts TIMESTAMP
);