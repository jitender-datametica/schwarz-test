CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_tierkategorie_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
werk_id BIGNUMERIC(38,0) NOT NULL,
tierkategorie_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);