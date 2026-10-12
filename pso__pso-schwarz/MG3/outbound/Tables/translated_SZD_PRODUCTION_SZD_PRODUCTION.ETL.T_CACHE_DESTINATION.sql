CREATE OR REPLACE TABLE szd_production_etl.t_cache_destination (
lot_relation_id STRING(100),
ship_destination_cd STRING(10),
nominated_total_cartons NUMERIC(29,5),
booked_total_cartons NUMERIC(29,5),
booked_pieces_per_carton NUMERIC(29,5),
net_weight NUMERIC(29,5),
gross_weight NUMERIC(29,5),
length NUMERIC(29,5),
width NUMERIC(29,5),
height NUMERIC(29,5),
dwh_src_file_name STRING(500),
dwh_src_1_tmsp TIMESTAMP,
valid_from TIMESTAMP,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
nominated_pieces_per_carton NUMERIC(29,5)
);