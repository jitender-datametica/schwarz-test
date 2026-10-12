CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_competitor_2_mdm_competitor_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_competitor_cbxitem_competitor_code STRING(250),
src_competitor_cd STRING(20) COLLATE 'und:ci',
competitor_name STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);