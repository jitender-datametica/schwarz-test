CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_mp_ods (
mandant_id BIGNUMERIC(38,0) NOT NULL,
mp_ods_id BIGNUMERIC(38,0) NOT NULL,
mp_ods_bez STRING(50) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);