CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_countryoforigin_2_country_political_descr_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_countryoforigin_cbxitem_countryoforigin_code STRING(250),
src_land1 STRING(40),
lang_cd STRING(20),
country_pol_descr STRING(100) COLLATE 'und:ci',
nationality STRING(300) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);