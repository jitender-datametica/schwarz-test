CREATE OR REPLACE TABLE ldl_production_p_lew_load.t_ts_cbx_codelist_2_country_political_descr___2 (
client_id INTEGER,
country_pol_sid INTEGER,
lang_sid INTEGER,
lang_cd STRING(20),
country_pol_descr STRING(100) COLLATE 'und:ci',
nationality STRING(300) COLLATE 'und:ci',
dwh_load_id INTEGER,
record_id STRING(1000),
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_dt STRING(1000),
error_fg INTEGER
);