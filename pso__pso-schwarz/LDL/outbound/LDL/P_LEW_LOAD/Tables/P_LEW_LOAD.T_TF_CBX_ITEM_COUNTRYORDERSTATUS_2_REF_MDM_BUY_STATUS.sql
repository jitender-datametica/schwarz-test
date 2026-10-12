CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_countryorderstatus_2_ref_mdm_buy_status (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_countryorderstatus_cbxitem_countryorderstatus_code STRING(250),
buy_status_cd STRING(20) COLLATE 'und:ci',
buy_status STRING(100) COLLATE 'und:ci',
buy_status_descr STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);