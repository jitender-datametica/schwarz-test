CREATE OR REPLACE TABLE szd_production_etl.t_cache_fpol_transhipment_location (
location_sid INTEGER,
valid_from TIMESTAMP,
transhipment_location_type_cd STRING(50),
port_price_group_cd STRING(50),
dwh_valid_fg BOOL,
transhipment_location_cd STRING(50),
transhipment_location_name STRING(100),
city_name STRING(100),
country_pol_cd STRING(3),
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_src_file_name STRING(500),
dwh_src_1_tmsp TIMESTAMP,
valid_to TIMESTAMP
);