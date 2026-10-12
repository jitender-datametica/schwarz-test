CREATE TABLE IF NOT EXISTS kfl_production_dbp_dialog.d_mp_mp_var_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
mp_id BIGNUMERIC(38,0) NOT NULL,
mp_var_id BIGNUMERIC(38,0) NOT NULL,
mp_sub_var_id BIGNUMERIC(38,0) NOT NULL,
mp_var_val NUMERIC(18,2),
mp_var_bez STRING(100) COLLATE 'und:ci'
);