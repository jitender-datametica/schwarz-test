CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_continenttype_2_mdm_market_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_continenttype_cbxitem_continenttype_code STRING(250),
market_cd STRING(20) COLLATE 'und:ci',
market STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);