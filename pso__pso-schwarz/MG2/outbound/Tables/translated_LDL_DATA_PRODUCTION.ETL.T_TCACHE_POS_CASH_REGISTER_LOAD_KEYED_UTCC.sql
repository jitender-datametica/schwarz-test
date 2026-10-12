CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_pos_cash_register_load_keyed_utcc (
src_country_cd STRING(20),
src_orig_store_nr BIGNUMERIC(38,0),
src_cash_register_nr BIGNUMERIC(38,0),
src_pos_type STRING(3),
cash_register_type_cd STRING(3),
country_org_cd STRING(2),
curr_cd STRING(3),
cash_register_sid BIGNUMERIC(38,0),
country_org_sid BIGNUMERIC(38,0),
real_estate_sid BIGNUMERIC(38,0),
store_sid BIGNUMERIC(38,0),
extraction_ts TIMESTAMP,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_node_cd STRING(20) NOT NULL
);