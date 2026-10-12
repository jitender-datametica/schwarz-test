CREATE OR REPLACE TABLE szd_production_etl.t_cache_lot (
lot_nr STRING(50),
booked_teu BIGNUMERIC(29,10),
nominated_teu BIGNUMERIC(29,10),
booked_total_cartons BIGNUMERIC(29,10),
nominated_total_cartons BIGNUMERIC(29,10),
dwh_created_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
valid_from TIMESTAMP,
shipped_teu BIGNUMERIC(29,10)
);