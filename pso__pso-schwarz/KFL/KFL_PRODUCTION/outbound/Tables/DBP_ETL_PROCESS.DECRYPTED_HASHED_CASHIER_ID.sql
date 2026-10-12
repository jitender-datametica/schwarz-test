CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.decrypted_hashed_cashier_id (
hashed_cashier_id STRING(255),
mandant_id BIGNUMERIC(38,0),
extended_fg INTEGER,
config_val BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
kassierer_nr STRING(4),
hash_generation_dt DATE
);