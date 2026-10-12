CREATE OR REPLACE TABLE szd_production_etl.t_cache_gtin_level_2 (
system_id STRING(100),
shipped_cartons NUMERIC(29,5),
pieces_per_carton NUMERIC(29,5),
net_weight NUMERIC(29,5),
gross_weight NUMERIC(29,5),
length NUMERIC(29,5),
width NUMERIC(29,5),
height NUMERIC(29,5),
dwh_src_file_name STRING(500),
dwh_src_1_tmsp TIMESTAMP,
update_timestamp TIMESTAMP,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
valid_to TIMESTAMP
);