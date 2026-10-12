CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_kz_sperrung (
mandant_id BIGNUMERIC(38,0) NOT NULL,
sperr_id STRING(1) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);