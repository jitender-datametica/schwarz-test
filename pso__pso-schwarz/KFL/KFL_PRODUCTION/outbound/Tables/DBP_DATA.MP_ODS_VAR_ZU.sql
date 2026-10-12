CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mp_ods_var_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
mp_ods_id BIGNUMERIC(38,0) NOT NULL,
mp_ods_var_id BIGNUMERIC(38,0) NOT NULL,
mp_ods_sub_var_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
mp_ods_var_val NUMERIC(18,2) NOT NULL,
mp_ods_var_bez STRING(100) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);