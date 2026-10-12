CREATE OR REPLACE TABLE smp_production_etl.las_audience_shopper (
country_id STRING(100) OPTIONS(description='Country iso code'),
audience_type_id STRING(100) OPTIONS(description='Audience type r or p'),
audience_id STRING(100) OPTIONS(description='Audience/Universe/Segement ID'),
category_name STRING(500) OPTIONS(description='Category Name '),
audience_name STRING(500) OPTIONS(description='Audience/Universe/Segement Name'),
shopper_id STRING(100) OPTIONS(description='Shopper ID (ssoID)'),
cell_group_id STRING(100) OPTIONS(description='AB Group: active (Test)/control (Control)'),
last_update_timestamp DATETIME OPTIONS(description='Delivery timestamp_ntz(9) from LAS'),
load_timestamp DATETIME OPTIONS(description='timestamp_ntz(9) for loading')
) OPTIONS(description='LAS Audiences/Universes');