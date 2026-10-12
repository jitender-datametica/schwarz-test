CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_countryoforigin_2_country_political (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_countryoforigin_cbxitem_countryoforigin_code STRING(250),
src_land1 STRING(20),
country_pol_name STRING(100) COLLATE 'und:ci',
curr_iso_cd STRING(40),
lang_cd STRING(20),
curr_cd STRING(20),
iso_code2 STRING(20),
iso_code3 STRING(20),
member_eu_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);